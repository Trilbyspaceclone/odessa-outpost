/obj/structure/table/standard
	icon_state = "plain_preview"
	color = "#EEEEEE"
	New()
		material = get_material_by_name(MATERIAL_PLASTIC)
		..()

/obj/structure/table/steel
	icon_state = "plain_preview"
	color = "#666666"
	New()
		material = get_material_by_name(MATERIAL_STEEL)
		..()

/obj/structure/table/marble
	icon_state = "stone_preview"
	color = "#CCCCCC"
	New()
		material = get_material_by_name(MATERIAL_MARBLE)
		..()

/obj/structure/table/reinforced
	icon_state = "reinf_preview"
	color = "#EEEEEE"
	New()
		material = get_material_by_name(MATERIAL_PLASTIC)
		reinforced = get_material_by_name(MATERIAL_STEEL)
		..()

/obj/structure/table/steel_reinforced
	icon_state = "reinf_preview"
	color = "#666666"
	New()
		material = get_material_by_name(MATERIAL_STEEL)
		reinforced = get_material_by_name(MATERIAL_STEEL)
		..()

/obj/structure/table/woodentable
	icon_state = "plain_preview"
	color = "#824B28"
	New()
		material = get_material_by_name(MATERIAL_WOOD)
		..()

/obj/structure/table/gamblingtable
	icon_state = "gamble_preview"
	New()
		material = get_material_by_name(MATERIAL_WOOD)
		custom_appearance = custom_table_appearance["Gambling"] //gambling carpet
		..()

/obj/structure/table/glass
	icon_state = "plain_preview"
	color = "#00E1FF"
	alpha = 77 // 0.3 * 255
	New()
		material = get_material_by_name(MATERIAL_GLASS)
		..()

/obj/structure/table/plasmaglass
	icon_state = "plain_preview"
	color = "#FC2BC5"
	alpha = 77 // 0.3 * 255
	New()
		material = get_material_by_name(MATERIAL_PLASMAGLASS)
		..()

/obj/structure/table/holotable
	icon_state = "holo_preview"
	color = "#EEEEEE"
	New()
		material = get_material_by_name("holo[MATERIAL_PLASTIC]")
		..()

/obj/structure/table/holo_woodentable
	icon_state = "holo_preview"
	New()
		material = get_material_by_name("holowood")
		..()

/obj/structure/table/bar_special
	icon_state = "bar_table_preview"
	New()
		material = get_material_by_name(MATERIAL_STEEL)
		custom_appearance = custom_table_appearance["Bar - special"] //bar table
		reinforced = get_material_by_name(MATERIAL_STEEL)
		..()

/obj/structure/table/onestar
	icon_state = "onestar_preview"
	New()
		material = get_material_by_name(MATERIAL_STEEL)
		custom_appearance = custom_table_appearance["OneStar"] //one star table
		reinforced = get_material_by_name(MATERIAL_STEEL)
		..()

//BENCH PRESETS
/obj/structure/table/bench/standard
	icon_state = "plain_preview"
	color = "#EEEEEE"

/obj/structure/table/bench/standard/New()
	material = get_material_by_name(MATERIAL_PLASTIC)
	..()

/obj/structure/table/bench/steel
	icon_state = "plain_preview"
	color = "#666666"

/obj/structure/table/bench/steel/New()
	material = get_material_by_name(MATERIAL_STEEL)
	..()


/obj/structure/table/bench/marble
	icon_state = "stone_preview"
	color = "#CCCCCC"

/obj/structure/table/bench/marble/New()
	material = get_material_by_name(MATERIAL_MARBLE)
	..()

/obj/structure/table/bench/wooden
	icon_state = "plain_preview"
	color = "#824B28"

/obj/structure/table/bench/wooden/New()
	material = get_material_by_name(MATERIAL_WOOD)
	..()

/obj/structure/table/bench/padded
	icon_state = "padded_preview"

/obj/structure/table/bench/padded/New()
	material = get_material_by_name(MATERIAL_PLASTIC)
	..()

/obj/structure/table/bench/glass
	icon_state = "plain_preview"
	color = "#00E1FF"
	alpha = 77 // 0.3 * 255

/obj/structure/table/bench/glass/New()
	material = get_material_by_name(MATERIAL_GLASS)
	..()