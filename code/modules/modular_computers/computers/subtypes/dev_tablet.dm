/obj/item/modular_computer/tablet
	name = "tablet computer"
	desc = "A small, portable microcomputer."
	icon = 'icons/obj/modular_tablet.dmi'
	icon_state = "tablet"
	matter = list(MATERIAL_STEEL = 5, MATERIAL_GLASS = 2)

	icon_state_menu = "menu"
	hardware_flag = PROGRAM_TABLET
	max_hardware_size = 2 //Sos change
	w_class = ITEM_SIZE_SMALL
	screen_light_strength = 2.1
	screen_light_range = 2.1
	price_tag = 100
	suitable_cell = /obj/item/weapon/cell/small //We take small battery

/obj/item/modular_computer/tablet/lease
	desc = "A small, portable microcomputer. This one has a gold and blue stripe, and a serial number stamped into the case."
	icon_state = "tabletsol"

/obj/item/modular_computer/tablet/Created()
	qdel(processor_unit)
	qdel(tesla_link)
	qdel(hard_drive)
	qdel(network_card)
	qdel(scanner)
