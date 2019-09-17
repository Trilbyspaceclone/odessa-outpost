/obj/item/clothing/shoes/galoshes
	desc = "A pair of slip-resistant rubber boots used for janitorial work."
	name = "galoshes"
	icon_state = "galoshes"
	permeability_coefficient = 0.05
	siemens_coefficient = 0 // DAMN BOI
	item_flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1
	species_restricted = null

/obj/item/clothing/shoes/jackboots
	name = "jackboots"
	desc = "A pair of standard-issue jackboots typically worn by security personnel."
	icon_state = "jackboots"
	item_state = "jackboots"
	force = WEAPON_FORCE_WEAK
	armor = list(melee = 30, bullet = 20, energy = 20, bomb = 20, bio = 0, rad = 0)
	siemens_coefficient = 0.6
	can_hold_knife = 1

/obj/item/clothing/shoes/reinforced
	name = "reinforced boots"
	desc = "A pair of metallic boots designed for industrial environments."
	icon_state = "reinforced"
	item_state = "reinforced"
	force = 2
	armor = list(melee = 30, bullet = 25, energy = 15, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.5

/obj/item/clothing/shoes/workboots
	name = "workboots"
	desc = "A pair of steel-toed utility workboots."
	icon_state = "workboots"
	item_state = "workboots"
	armor = list(melee = 40, bullet = 25, energy = 20, bomb = 20, bio = 0, rad = 20)
	siemens_coefficient = 0
	can_hold_knife = 1
