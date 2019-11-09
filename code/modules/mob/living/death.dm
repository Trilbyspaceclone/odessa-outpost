/mob/living/carbon/death(gibbed)
	if(!gibbed)
		SetDizziness(0)
		SetJitteriness(0)
		SetStuttering(0)



	for(var/s in owned_soul_links)
		var/datum/soul_link/S = s
		S.owner_died(gibbed)
	for(var/s in shared_soul_links)
		var/datum/soul_link/S = s
		S.sharer_died(gibbed)

	. = ..()