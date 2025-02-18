/mob/living/carbon/human/proc/update_eyes()
	var/obj/item/organ/internal/eyes/eyes = internal_organs_by_name[BP_EYES]
	if(eyes)
		eyes.update_colour()
		regenerate_icons()

/mob/living/carbon/var/list/internal_organs = list()
/mob/living/carbon/human/var/list/organs = list()
/mob/living/carbon/human/var/list/organs_by_name = list() // map organ names to organs
/mob/living/carbon/human/var/list/internal_organs_by_name = list() // so internal organs have less ickiness too

// Takes care of organ related updates, such as broken and missing limbs
/mob/living/carbon/human/proc/handle_organs()

	var/force_process = 0
	var/damage_this_tick = getBruteLoss() + getFireLoss() + getToxLoss()
	if(damage_this_tick > last_dam)
		force_process = 1
	last_dam = damage_this_tick
	if(force_process)
		bad_external_organs.Cut()
		for(var/obj/item/organ/external/Ex in organs)
			bad_external_organs |= Ex

	//processing internal organs is pretty cheap, do that first.
	for(var/obj/item/organ/I in internal_organs)
		I.Process()

	handle_stance()
	handle_grasp()

	if(!force_process && !bad_external_organs.len)
		return

	for(var/obj/item/organ/external/E in bad_external_organs)
		if(!E)
			continue
		if(!E.need_process())
			bad_external_organs -= E
			continue
		else
			E.Process()

			if (!lying && !buckled && world.time - l_move_time < 15)
			//Moving around with fractured ribs won't do you any good
				if (E.is_broken() && E.internal_organs && E.internal_organs.len && prob(15))
					var/obj/item/organ/I = pick(E.internal_organs)
					custom_pain("You feel broken bones moving in your [E.name]!", 1)
					I.take_damage(rand(3,5))

				//Moving makes open wounds get infected much faster
				if (E.wounds.len)
					for(var/datum/wound/W in E.wounds)
						if (W.infection_check())
							W.germ_level += 1

/mob/living/carbon/human/proc/handle_stance()
	// Don't need to process any of this if they aren't standing anyways
	// unless their stance is damaged, and we want to check if they should stay down
	if (!stance_damage && (lying || resting) && (life_tick % 4) == 0)
		return

	stance_damage = 0

	// Buckled to a bed/chair. Stance damage is forced to 0 since they're sitting on something solid
	if (istype(buckled, /obj/structure/bed))
		return

	for(var/obj/item/organ/external/E in organs_by_name)
		if(!E.can_stand) continue
		//should just be !E.is_usable() here but dislocation screws that up.
		if(!E || (E.status & (ORGAN_MUTATED|ORGAN_DEAD)) || E.is_stump())
			stance_damage += 2 // let it fail even if just foot&leg
		else if (E.is_malfunctioning())
			//malfunctioning only happens intermittently so treat it as a missing limb when it procs
			stance_damage += 2
			if(prob(10))
				visible_message("\The [src]'s [E.name] [pick("twitches", "shudders")] and sparks!")
				var/datum/effect/effect/system/spark_spread/spark_system = new ()
				spark_system.set_up(5, 0, src)
				spark_system.attach(src)
				spark_system.start()
				spawn(10)
					qdel(spark_system)
		else if (E.is_broken() || !E.is_usable())
			stance_damage += 2
		else if (E.is_dislocated())
			stance_damage += 0.5

	// Canes and crutches help you stand (if the latter is ever added)
	// One cane mitigates a broken leg+foot, or a missing foot.
	// Two canes are needed for a lost leg. If you are missing both legs, canes aren't gonna help you.
	if (l_hand && istype(l_hand, /obj/item/weapon/cane))
		stance_damage -= 2
	if (r_hand && istype(r_hand, /obj/item/weapon/cane))
		stance_damage -= 2

	// standing is poor
	if(stance_damage >= 4 || (stance_damage >= 2 && prob(5)))
		if(!(lying || resting))
			if(species && !(species.flags & NO_PAIN))
				emote("scream")
			custom_emote(1, "collapses!")
		Weaken(5) //can't emote while weakened, apparently.

/mob/living/carbon/human/proc/handle_grasp()
	if(!l_hand && !r_hand)
		return

	// You should not be able to pick anything up, but stranger things have happened.
	if(l_hand)
		for(var/limb_tag in list(BP_L_ARM))
			var/obj/item/organ/external/E = get_organ(limb_tag)
			if(!E)
				visible_message(SPAN_DANGER("Lacking a functioning left hand, \the [src] drops \the [l_hand]."))
				drop_from_inventory(l_hand)
				break

	if(r_hand)
		for(var/limb_tag in list(BP_R_ARM))
			var/obj/item/organ/external/E = get_organ(limb_tag)
			if(!E)
				visible_message(SPAN_DANGER("Lacking a functioning right hand, \the [src] drops \the [r_hand]."))
				drop_from_inventory(r_hand)
				break

	// Check again...
	if(!l_hand && !r_hand)
		return

	for (var/obj/item/organ/external/E in organs)
		if(!E || !E.can_grasp || (E.status & ORGAN_SPLINTED))
			continue

		if(E.is_broken() || E.is_dislocated())
			switch(E.body_part)
				if(ARM_LEFT)
					if(!l_hand)
						continue
					drop_from_inventory(l_hand)
				if(ARM_RIGHT)
					if(!r_hand)
						continue
					drop_from_inventory(r_hand)

			var/emote_scream = pick("screams in pain and ", "lets out a sharp cry and ", "cries out and ")
			emote("me", 1, "[(species.flags & NO_PAIN) ? "" : emote_scream ]drops what they were holding in their [E.name]!")

		else if(E.is_malfunctioning())
			switch(E.body_part)
				if(ARM_LEFT)
					if(!l_hand)
						continue
					drop_from_inventory(l_hand)
				if(ARM_RIGHT)
					if(!r_hand)
						continue
					drop_from_inventory(r_hand)

			emote("pain", 1, "drops what they were holding, their [E.name] malfunctioning!")

			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, src)
			spark_system.attach(src)
			spark_system.start()
			spawn(10)
				qdel(spark_system)

//Handles chem traces
/mob/living/carbon/human/proc/handle_trace_chems()
	//New are added for reagents to random organs.
	for(var/datum/reagent/A in reagents.reagent_list)
		var/obj/item/organ/O = pick(organs)
		O.trace_chemicals[A.name] = 100

/mob/living/carbon/human/proc/sync_organ_dna()
	var/list/all_bits = internal_organs|organs
	for(var/obj/item/organ/O in all_bits)
		O.set_dna(dna)

/mob/living/carbon/human/is_asystole()
	if(isSynthetic())
		var/obj/item/organ/internal/cell/C = internal_organs_by_name[BP_CELL]
		if(istype(C))
			if(!C.is_usable())
				return TRUE
	else if(should_have_organ(BP_HEART))
		var/obj/item/organ/internal/heart/heart = internal_organs_by_name[BP_HEART]
		if(!istype(heart) || !heart.is_working())
			return TRUE
	return FALSE

// basically has_limb()
/mob/living/carbon/human/has_appendage(var/appendage_check)	//returns TRUE if found, type of organ modification if limb is robotic, FALSE if not found

	if (appendage_check == BP_CHEST)
		return TRUE

	var/obj/item/organ/external/appendage
	appendage = organs_by_name[appendage_check]

	if(appendage && !appendage.is_stump())
		if(BP_IS_ROBOTIC(appendage))
			return appendage.nature
		else return TRUE
	return FALSE

/mob/living/carbon/human/proc/restore_organ(organ_type, var/show_message = FALSE, var/heal = FALSE,)
	var/obj/item/organ/E = organs_by_name[organ_type]
	if(E && E.organ_tag != BP_HEAD && !E.vital && !E.is_usable())	//Skips heads and vital bits...
		E.removed()//...because no one wants their head to explode to make way for a new one.
		qdel(E)
		E= null
	if(!E)
		if(organ_type in BP_ALL_LIMBS)
			var/list/organ_data = species.has_limbs[organ_type]
			var/limb_path = organ_data["path"]
			var/obj/item/organ/external/O = new limb_path(src)
			organ_data["descriptor"] = O.name
			var/datum/reagent/blood/B = locate(/datum/reagent/blood) in vessel.reagent_list
			blood_splatter(src,B,1)
			O.set_dna(dna)
			update_body()
			if (show_message)
				to_chat(src, SPAN_DANGER("With a shower of fresh blood, a new [O.name] forms."))
				visible_message(SPAN_DANGER("With a shower of fresh blood, a length of biomass shoots from [src]'s [O.amputation_point], forming a new [O.name]!"))
			return TRUE
		else
			var/list/organ_data = species.has_organ[organ_type]
			var/organ_path = organ_data["path"]
			var/obj/item/organ/internal/O = new organ_path(src)
			organ_data["descriptor"] = O.name
			O.set_dna(dna)
			update_body()
			if(mind.changeling && O.organ_tag == BP_BRAIN)
				O.vital = 0
			return TRUE
	else
		if(organ_type in BP_ALL_LIMBS)
			var/obj/item/organ/external/O = E
			if (heal && (O.damage > 0 || O.status & (ORGAN_BROKEN) || O.has_internal_bleeding()))
				O.status &= ~ORGAN_BROKEN
				for(var/datum/wound/W in O.wounds) 
					if(W.internal)
						O.wounds.Remove(W)
						qdel(W)
						O.update_wounds()
				for(var/datum/wound/W in O.wounds)
					if(W.wound_damage() == 0 && prob(50))
						O.wounds -= W
				return TRUE
		else
			if (heal && (E.damage > 0 || E.status & (ORGAN_BROKEN)))
				E.status &= ~ORGAN_BROKEN
				return TRUE
	return FALSE