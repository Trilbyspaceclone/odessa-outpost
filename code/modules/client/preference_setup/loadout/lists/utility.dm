// "Useful" items - I'm guessing things that might be used at work?
/datum/gear/utility
	display_name = "briefcase"
	path = /obj/item/weapon/storage/briefcase
	sort_category = "Utility"

/datum/gear/utility/clipboard
	display_name = "clipboard"
	path = /obj/item/weapon/clipboard

/datum/gear/utility/folder_colorable
	display_name = "folder, colorable"
	flags = GEAR_HAS_COLOR_SELECTION
	path = /obj/item/weapon/folder

/datum/gear/utility/folder_presets
	display_name = "folder"
	path = /obj/item/weapon/folder

/datum/gear/utility/folder_presets/New()
	..()
	var/folder = list(
		"Grey"			=	/obj/item/weapon/folder,
		"White"			=	/obj/item/weapon/folder/white,
		"Red"			=	/obj/item/weapon/folder/red,
		"Yellow"		=	/obj/item/weapon/folder/yellow,
		"Blue"			=	/obj/item/weapon/folder/blue,
	)
	gear_tweaks += new /datum/gear_tweak/path(folder)

/datum/gear/utility/paicard
	display_name = "personal AI device"
	path = /obj/item/device/paicard
	cost = 2

/datum/gear/utility/cheaptablet
	display_name = "tablet computer, cheap"
	path = /obj/item/modular_computer/tablet/preset/custom_loadout/cheap
	cost = 2

/datum/gear/utility/normaltablet
	display_name = "advanced tablet computer"
	path = /obj/item/modular_computer/tablet/preset/custom_loadout/advanced
	cost = 3

/datum/gear/utility/crowbar
	display_name = "crowbar"
	path = /obj/item/weapon/tool/crowbar

/datum/gear/utility/flashlight
	display_name = "flashlight"
	path = /obj/item/device/lighting/toggleable/flashlight