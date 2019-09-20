/obj/item/clothing/glasses/powered/thermal
	name = "optical thermal scanner"
	desc = "Thermals in the shape of glasses."
	icon_state = "thermal"
	item_state = "glasses"
	action_button_name = "Toggle Optical Matrix"
	origin_tech = list(TECH_MAGNET = 3)
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	flash_protection = FLASH_PROTECTION_REDUCED
	price_tag = 1000

	tick_cost = 0.5

/obj/item/clothing/glasses/powered/thermal/emp_act(severity)
	if(ishuman(src.loc))
		var/mob/living/carbon/human/M = src.loc
		if(M.glasses == src)
			to_chat(M, SPAN_DANGER("[src] overloads and blinds you!"))
			M.eye_blind = 3
			M.eye_blurry = 5
			// Don't cure being nearsighted
			if(!(M.disabilities & NEARSIGHTED))
				M.disabilities |= NEARSIGHTED
				spawn(100)
					M.disabilities &= ~NEARSIGHTED
	..()

/obj/item/clothing/glasses/powered/thermal/Initialize()
	. = ..()
	overlay = global_hud.thermal

/obj/item/clothing/glasses/powered/thermal/syndi	//These are now a traitor item, concealed as mesons.	-Pete
	name = "optical meson scanner"
	desc = "Used for seeing walls, floors, and stuff through anything."
	icon_state = "meson"
	origin_tech = list(TECH_MAGNET = 3, TECH_ILLEGAL = 4)

/obj/item/clothing/glasses/powered/thermal/onestar
	name = "type-73 zhenchayuan goggles"
	desc = "Chinese thermals in the shape of goggles."
	icon_state = "onestar_thermal"
	off_state = "onestar_thermal"

/obj/item/clothing/glasses/powered/thermal/plain
	toggleable = FALSE
	activation_sound = null
	action_button_name = null

/obj/item/clothing/glasses/powered/thermal/plain/monocle
	name = "thermoncle"
	desc = "A monocle thermal."
	icon_state = "thermoncle"
	flags = null //doesn't protect eyes because it's a monocle, duh

	body_parts_covered = 0

/obj/item/clothing/glasses/powered/thermal/plain/eyepatch
	name = "optical thermal eyepatch"
	desc = "An eyepatch with built-in thermal optics"
	icon_state = "eyepatch"
	item_state = "eyepatch"
	body_parts_covered = 0

/obj/item/clothing/glasses/powered/thermal/plain/jensen
	name = "optical thermal implants"
	desc = "A set of implantable lenses designed to augment your vision"
	icon_state = "thermalimplants"
	item_state = "syringe_kit"

