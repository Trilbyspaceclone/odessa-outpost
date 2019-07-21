/obj/item/weapon/computer_hardware/hard_drive/portable/design
	name = "design disk"
	icon_state = "yellow"
	desc = "Data disk used to store autolathe designs."
	max_capacity = 0	// Up to 255 designs, automatically reduced to the nearest power of 2
	origin_tech = list(TECH_DATA = 3) // Most design disks end up being 64 to 128 GQ
	matter = list(MATERIAL_STEEL = 1, MATERIAL_PLASTIC = 2, MATERIAL_GOLD = 0.5)
	var/list/designs = list()

/obj/item/weapon/computer_hardware/hard_drive/portable/design/install_default_files()
	..()
	// Add design files to the disk
	for(var/design_typepath in designs)
		var/datum/computer_file/binary/design/D = new
		D.set_design_type(design_typepath)
		if(license)
			D.set_copy_protection(TRUE)

		store_file(D, TRUE) //Will force the disk to accept it in spite of size.

	// Prevent people from breaking DRM by copying files across protected disks.
	// Stops people from screwing around with unprotected disks too.
	read_only = TRUE
	return TRUE


// Asters
/obj/item/weapon/computer_hardware/hard_drive/portable/design/tools
	disk_name = "Asters Basic Tool Pack"
	icon_state = "guild"

	license = 0
	designs = list(
		/datum/design/autolathe/tool/hatchet,
		/datum/design/autolathe/tool/minihoe,
		/datum/design/autolathe/tool/ducttape,
		/datum/design/autolathe/tool/knife,
		/datum/design/autolathe/misc/heavyflashlight,
		/datum/design/autolathe/tool/crowbar,
		/datum/design/autolathe/tool/screwdriver,
		/datum/design/autolathe/tool/wirecutters,
		/datum/design/autolathe/tool/wrench,
		/datum/design/autolathe/tool/saw,
		/datum/design/autolathe/tool/multitool,
		/datum/design/autolathe/tool/pickaxe,
		/datum/design/autolathe/tool/shovel,
		/datum/design/autolathe/tool/spade,
		/datum/design/autolathe/device/t_scanner,
		/datum/design/autolathe/tool/rcd_ammo,
		/datum/design/autolathe/tool/weldertool,
		/datum/design/autolathe/tool/weldinggoggles,
		/datum/design/autolathe/tool/weldermask,
		/datum/design/autolathe/device/flamethrower
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/misc
	disk_name = "Asters Miscellaneous Pack"
	icon_state = "guild"

	license = 0
	designs = list(
		/datum/design/autolathe/misc/flashlight,
		/datum/design/autolathe/tool/ducttape,
		/datum/design/autolathe/misc/extinguisher,
		/datum/design/autolathe/misc/radio_headset,
		/datum/design/autolathe/misc/radio_bounced,
		/datum/design/autolathe/misc/ashtray,
		/datum/design/autolathe/container/drinkingglass,
		/datum/design/autolathe/container/carafe,
		/datum/design/autolathe/container/insulated_pitcher,
		/datum/design/autolathe/container/bucket,
		/datum/design/autolathe/container/jar,
		/datum/design/autolathe/container/syringe,
		/datum/design/autolathe/container/vial,
		/datum/design/autolathe/container/beaker,
		/datum/design/autolathe/container/beaker_large,
		/datum/design/autolathe/container/pill_bottle,
		/datum/design/autolathe/container/spray,
		/datum/design/autolathe/misc/cane,
		/datum/design/autolathe/misc/floor_light,
		/datum/design/autolathe/misc/tube,
		/datum/design/autolathe/misc/bulb,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/devices
	disk_name = "Asters Devices and Instruments"
	icon_state = "guild"

	license = 10
	designs = list(
		/datum/design/autolathe/misc/flashlight,
		/datum/design/autolathe/device/analyzer,
		/datum/design/autolathe/device/plant_analyzer,
		/datum/design/autolathe/device/healthanalyzer,
		/datum/design/research/item/medical/mass_spectrometer,
		/datum/design/research/item/medical/reagent_scanner,
		/datum/design/research/item/medical/robot_scanner,
		/datum/design/autolathe/device/slime_scanner,
		/datum/design/autolathe/device/antibody_scanner,
		/datum/design/autolathe/device/megaphone,
		/datum/design/autolathe/device/t_scanner,
		/datum/design/autolathe/device/gps,
		/datum/design/autolathe/device/destTagger,
		/datum/design/autolathe/device/export_scanner,
		/datum/design/autolathe/device/implanter,
		/datum/design/autolathe/device/hand_labeler,
		/datum/design/research/item/light_replacer
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/robustcells
	disk_name = "Asters Robustcells"
	icon_state = "guild"

	license = 8
	designs = list(
		/datum/design/autolathe/cell/large,
		/datum/design/autolathe/cell/large/high,
		/datum/design/autolathe/cell/medium,
		/datum/design/autolathe/cell/medium/high,
		/datum/design/autolathe/cell/small,
		/datum/design/autolathe/cell/small/high,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/cargo
	disk_name = "Asters Tidbits Factory"
	icon_state = "guild"

	license = -1
	designs = list(
		//Basic Tools
		/datum/design/autolathe/tool/hatchet,
		/datum/design/autolathe/tool/minihoe,
		/datum/design/autolathe/tool/ducttape,
		/datum/design/autolathe/tool/knife,
		/datum/design/autolathe/misc/heavyflashlight,
		/datum/design/autolathe/tool/crowbar,
		/datum/design/autolathe/tool/screwdriver,
		/datum/design/autolathe/tool/wirecutters,
		/datum/design/autolathe/tool/wrench,
		/datum/design/autolathe/tool/saw,
		/datum/design/autolathe/tool/multitool,
		/datum/design/autolathe/tool/pickaxe,
		/datum/design/autolathe/tool/shovel,
		/datum/design/autolathe/tool/spade,
		/datum/design/autolathe/device/t_scanner,
		/datum/design/autolathe/tool/rcd_ammo,
		/datum/design/autolathe/tool/weldertool,
		/datum/design/autolathe/tool/weldinggoggles,
		/datum/design/autolathe/tool/weldermask,
		/datum/design/autolathe/device/flamethrower,
		//Misc
		/datum/design/autolathe/misc/flashlight,
		/datum/design/autolathe/tool/ducttape,
		/datum/design/autolathe/misc/extinguisher,
		/datum/design/autolathe/misc/radio_headset,
		/datum/design/autolathe/misc/radio_bounced,
		/datum/design/autolathe/misc/ashtray,
		/datum/design/autolathe/container/drinkingglass,
		/datum/design/autolathe/container/carafe,
		/datum/design/autolathe/container/insulated_pitcher,
		/datum/design/autolathe/container/bucket,
		/datum/design/autolathe/container/jar,
		/datum/design/autolathe/container/syringe,
		/datum/design/autolathe/container/vial,
		/datum/design/autolathe/container/beaker,
		/datum/design/autolathe/container/beaker_large,
		/datum/design/autolathe/container/pill_bottle,
		/datum/design/autolathe/container/spray,
		/datum/design/autolathe/misc/cane,
		/datum/design/autolathe/misc/floor_light,
		/datum/design/autolathe/misc/tube,
		/datum/design/autolathe/misc/bulb,
		//Devices
		/datum/design/autolathe/misc/flashlight,
		/datum/design/autolathe/device/analyzer,
		/datum/design/autolathe/device/plant_analyzer,
		/datum/design/autolathe/device/healthanalyzer,
		/datum/design/research/item/medical/mass_spectrometer,
		/datum/design/research/item/medical/reagent_scanner,
		/datum/design/research/item/medical/robot_scanner,
		/datum/design/autolathe/device/slime_scanner,
		/datum/design/autolathe/device/antibody_scanner,
		/datum/design/autolathe/device/megaphone,
		/datum/design/autolathe/device/t_scanner,
		/datum/design/autolathe/device/gps,
		/datum/design/autolathe/device/destTagger,
		/datum/design/autolathe/device/export_scanner,
		/datum/design/autolathe/device/implanter,
		/datum/design/autolathe/device/hand_labeler,
		/datum/design/research/item/light_replacer,
		//Cells
		/datum/design/autolathe/cell/large,
		/datum/design/autolathe/cell/large/high,
		/datum/design/autolathe/cell/medium,
		/datum/design/autolathe/cell/medium/high,
		/datum/design/autolathe/cell/small,
		/datum/design/autolathe/cell/small/high,
	)

// Technomancers
/obj/item/weapon/computer_hardware/hard_drive/portable/design/components
	disk_name = "Technomancers ARK-034 Components"
	icon_state = "technomancers"

	license = 20
	designs = list(
		/datum/design/autolathe/part/consolescreen,
		/datum/design/research/item/part/smes_coil,
		/datum/design/research/item/part/basic_capacitor,
		/datum/design/research/item/part/basic_sensor,
		/datum/design/research/item/part/micro_mani,
		/datum/design/research/item/part/basic_micro_laser,
		/datum/design/research/item/part/basic_matter_bin,
		/datum/design/autolathe/part/igniter,
		/datum/design/autolathe/part/signaler,
		/datum/design/autolathe/part/sensor_infra,
		/datum/design/autolathe/part/timer,
		/datum/design/autolathe/part/sensor_prox,
		/datum/design/autolathe/part/camera_assembly,
		/datum/design/autolathe/part/laserguide,
	)


/obj/item/weapon/computer_hardware/hard_drive/portable/design/adv_tools
	disk_name = "Technomancers IJIRO-451 Advanced Tools"
	icon_state = "technomancers"

	license = 10
	designs = list(
		/datum/design/autolathe/tool/big_wrench,
		/datum/design/autolathe/tool/pneumatic_crowbar,
		/datum/design/research/item/weapon/mining/jackhammer,
		/datum/design/research/item/weapon/mining/drill,
		/datum/design/research/item/weapon/mining/drill_diamond,
		/datum/design/autolathe/tool/pickaxe_excavation,
		/datum/design/autolathe/tool/circularsaw,
		/datum/design/autolathe/tool/chainsaw,
		/datum/design/autolathe/tool/rcd,
		/datum/design/autolathe/tool/electric_screwdriver,
		/datum/design/autolathe/tool/combi_driver,
		/datum/design/autolathe/tool/armature_cutter,
		/datum/design/autolathe/part/diamondblade,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/circuits
	disk_name = "Technomancers ESPO-830 Circuits"
	icon_state = "technomancers"

	license = 10
	designs = list(
		/datum/design/autolathe/circuit/airlockmodule,
		/datum/design/autolathe/circuit/airalarm,
		/datum/design/autolathe/circuit/firealarm,
		/datum/design/autolathe/circuit/powermodule,
		/datum/design/autolathe/circuit/recharger,
		/datum/design/research/circuit/autolathe,
		/datum/design/autolathe/circuit/autolathe_disk_cloner,
		/datum/design/autolathe/circuit/vending,
		/datum/design/research/circuit/arcade_battle,
		/datum/design/research/circuit/arcade_orion_trail,
		/datum/design/research/circuit/teleconsole,
		/datum/design/research/circuit/operating,
		/datum/design/autolathe/circuit/helm,
		/datum/design/autolathe/circuit/nav,
		/datum/design/autolathe/circuit/centrifuge,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/engineering
	disk_name = "Technomancers Supply Factory"
	icon_state = "technomancers"
	license = -1 //Should make this disk infinite.

	designs = list(
		// From Components
		/datum/design/autolathe/part/consolescreen,
		/datum/design/research/item/part/smes_coil,
		/datum/design/research/item/part/basic_capacitor,
		/datum/design/research/item/part/basic_sensor,
		/datum/design/research/item/part/micro_mani,
		/datum/design/research/item/part/basic_micro_laser,
		/datum/design/research/item/part/basic_matter_bin,
		/datum/design/autolathe/part/igniter,
		/datum/design/autolathe/part/signaler,
		/datum/design/autolathe/part/sensor_infra,
		/datum/design/autolathe/part/timer,
		/datum/design/autolathe/part/sensor_prox,
		/datum/design/autolathe/part/camera_assembly,
		/datum/design/autolathe/part/laserguide,
		// From Tools
		/datum/design/autolathe/tool/big_wrench,
		/datum/design/autolathe/tool/pneumatic_crowbar,
		/datum/design/research/item/weapon/mining/jackhammer,
		/datum/design/research/item/weapon/mining/drill,
		/datum/design/research/item/weapon/mining/drill_diamond,
		/datum/design/autolathe/tool/pickaxe_excavation,
		/datum/design/autolathe/tool/circularsaw,
		/datum/design/autolathe/tool/chainsaw,
		/datum/design/autolathe/tool/rcd,
		/datum/design/autolathe/tool/electric_screwdriver,
		/datum/design/autolathe/tool/combi_driver,
		/datum/design/autolathe/tool/armature_cutter,
		/datum/design/autolathe/part/diamondblade,
		// From Circuits
		/datum/design/autolathe/circuit/airlockmodule,
		/datum/design/autolathe/circuit/airalarm,
		/datum/design/autolathe/circuit/firealarm,
		/datum/design/autolathe/circuit/powermodule,
		/datum/design/autolathe/circuit/recharger,
		/datum/design/research/circuit/autolathe,
		/datum/design/autolathe/circuit/autolathe_disk_cloner,
		/datum/design/autolathe/circuit/vending,
		/datum/design/research/circuit/arcade_battle,
		/datum/design/research/circuit/arcade_orion_trail,
		/datum/design/research/circuit/teleconsole,
		/datum/design/research/circuit/operating,
		/datum/design/autolathe/circuit/helm,
		/datum/design/autolathe/circuit/nav,
		/datum/design/autolathe/circuit/centrifuge,
		)


// Moebius
/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical
	disk_name = "Moebius Medical Designs"
	icon_state = "moebius"

	license = 20
	designs = list(
		/datum/design/autolathe/gun/syringe_gun,
		/datum/design/autolathe/misc/penflashlight,
		/datum/design/autolathe/tool/scalpel,
		/datum/design/autolathe/tool/circularsaw,
		/datum/design/autolathe/tool/surgicaldrill,
		/datum/design/autolathe/tool/retractor,
		/datum/design/autolathe/tool/cautery,
		/datum/design/autolathe/tool/hemostat,
		/datum/design/autolathe/tool/bonesetter,
		/datum/design/autolathe/container/syringe,
		/datum/design/autolathe/container/vial,
		/datum/design/autolathe/container/beaker,
		/datum/design/autolathe/container/beaker_large,
		/datum/design/autolathe/container/pill_bottle,
		/datum/design/autolathe/container/spray,
		/datum/design/autolathe/device/implanter,
		/datum/design/autolathe/container/syringegun_ammo,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/medical/cmo
	disk_name = "Moebius Medical Factory"
	license = -1 //Same disk, but for the CMO exclusively with endless uses.

/obj/item/weapon/computer_hardware/hard_drive/portable/design/computer
	disk_name = "Moebius Computer Parts"
	icon_state = "moebius"

	license = 20
	designs = list(
		/datum/design/autolathe/computer_part/frame_pda,
		/datum/design/autolathe/computer_part/frame_tablet,
		/datum/design/autolathe/computer_part/frame_laptop,
		/datum/design/research/item/modularcomponent/disk/micro,
		/datum/design/research/item/modularcomponent/disk/small,
		/datum/design/research/item/modularcomponent/disk/normal,
		/datum/design/research/item/modularcomponent/disk/advanced,
		/datum/design/research/item/modularcomponent/cpu/small,
		/datum/design/research/item/modularcomponent/cpu,
		/datum/design/research/item/modularcomponent/netcard/basic,
		/datum/design/research/item/modularcomponent/netcard/advanced,
		/datum/design/research/item/modularcomponent/netcard/wired,
		/datum/design/research/item/modularcomponent/cardslot,
		/datum/design/research/item/modularcomponent/teslalink,
		/datum/design/research/item/modularcomponent/portabledrive/basic,
		/datum/design/research/item/modularcomponent/nanoprinter,
		/datum/design/autolathe/computer_part/gps,
		/datum/design/autolathe/computer_part/led,
		/datum/design/autolathe/computer_part/scanner_paper,
		/datum/design/autolathe/computer_part/scanner_atmos,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/computer/rd
	disk_name = "Moebius Computer Factory"
	license = -1


// NeoTheology
/obj/item/weapon/computer_hardware/hard_drive/portable/design/nt_old_guns
	disk_name = "NeoTheology Armory of the Old Testament"
	icon_state = "neotheology"

	license = 3
	designs = list(
		/datum/design/autolathe/gun/mk58,
		/datum/design/autolathe/gun/mk58_wood,
		/datum/design/autolathe/gun/combat_shotgun,
		/datum/design/autolathe/gun/heavysniper,
		/datum/design/autolathe/gun/grenade_launcher,
		/datum/design/research/item/weapon/stunrevolver,
		/datum/design/autolathe/gun/taser,
		/datum/design/autolathe/gun/sniperrifle
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/nt_new_guns
	disk_name = "NeoTheology Armory of the New Testament"
	icon_state = "neotheology"

	license = 3
	designs = list(
		/datum/design/autolathe/gun/energy_crossbow,
		/datum/design/autolathe/gun/large_energy_crossbow,
		/datum/design/autolathe/gun/laser,
		/datum/design/autolathe/gun/pulse_rifle,
		/datum/design/autolathe/gun/pulse_rifle_destroyer,
		/datum/design/autolathe/gun/ionrifle,
	)


// Ironhammer
/obj/item/weapon/computer_hardware/hard_drive/portable/design/security
	disk_name = "Ironhammer Miscellaneous Pack"
	icon_state = "ironhammer"

	license = 20
	designs = list(
		/datum/design/autolathe/sec/secflashlight,
		/datum/design/research/item/flash,
		/datum/design/autolathe/sec/handcuffs,
		/datum/design/autolathe/misc/taperecorder,
		/datum/design/autolathe/tool/tacknife,
		/datum/design/autolathe/sec/beartrap,
		/datum/design/autolathe/sec/silencer,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/security/hos
	disk_name = "Ironhammer Miscellaneous Factory"
	license = -1


// Frozen Star
/obj/item/weapon/computer_hardware/hard_drive/portable/design/fs_cheap_guns
	disk_name = "Frozen Star Basic Civilian Pack"
	icon_state = "frozenstar"

	license = 7
	designs = list(
		/datum/design/autolathe/gun/giskard,
		/datum/design/autolathe/gun/olivaw,
		/datum/design/autolathe/gun/clarissa,
		/datum/design/autolathe/gun/revolver_detective,
		/datum/design/autolathe/gun/doublebarrel,
		/datum/design/autolathe/gun/pump_shotgun,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/fs_kinetic_guns //please, maintain general order (pistol>revolver>SMG>Other>Shotgun>GLs)+(smaller/less damaging caliber>bigger/more damaging caliber)
	disk_name = "Frozen Star Ultimate Protection Pack"
	icon_state = "frozenstar"

	license = 5
	designs = list(
		/datum/design/autolathe/gun/IH_sidearm, //pistols
		/datum/design/autolathe/gun/IH_machinepistol,
		/datum/design/autolathe/gun/lamia,
		/datum/design/autolathe/gun/deagle,
		/datum/design/autolathe/gun/revolver_consul, //revolvers
		/datum/design/autolathe/gun/revolver_deckard,
		/datum/design/autolathe/gun/revolver,
		/datum/design/autolathe/gun/idaho, //smgs
		/datum/design/autolathe/gun/wt550,
		/datum/design/autolathe/gun/IH_smg,
		/datum/design/autolathe/gun/atreides,
		/datum/design/autolathe/gun/smg_sol, //other
		/datum/design/autolathe/gun/smg_sol_rds,
		/datum/design/autolathe/gun/z8,
		/datum/design/autolathe/gun/IH_heavyrifle,
		/datum/design/autolathe/gun/ak47_fs,
		/datum/design/autolathe/gun/grenade_launcher_lenar, //GLs
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/fs_energy_guns
	disk_name = "Frozen Star Void Warrior Pack"
	icon_state = "frozenstar"

	license = 3
	designs = list(
		/datum/design/autolathe/gun/energygun_martin,
		/datum/design/autolathe/gun/energygun,
		/datum/design/autolathe/gun/pulse_rifle_cassad,
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/nonlethal_ammo //please, maintain general order (pistol>speedloaders>smg>other>shells)+(smaller/less damaging caliber>bigger/more damaging caliber)
	disk_name = "Frozen Star Nonlethal Ammo Pack"
	icon_state = "frozenstar"

	license = 20
	designs = list(
		/datum/design/autolathe/ammo/mg_cl32_rubber, //pistol mags
		/datum/design/autolathe/ammo/magazine_mc9mm_rubber,
		/datum/design/autolathe/ammo/magazine_c45m_rubber,
		/datum/design/autolathe/ammo/magazine_a10mm_rubber,
		/datum/design/autolathe/ammo/mg_cl44_rubber,
		/datum/design/autolathe/ammo/mg_a50_rubber,
		/datum/design/autolathe/ammo/sl_c138_rubber, //speed loaders
		/datum/design/autolathe/ammo/sl_cl44_rubber,
		/datum/design/autolathe/ammo/smg9mm_rubber, //smg mags
		/datum/design/autolathe/ammo/magazine_mc9mmt_rubber,
		/datum/design/autolathe/ammo/c45smg_rubber,
		/datum/design/autolathe/ammo/SMG_sol_rubber, //other mags
		/datum/design/autolathe/ammo/a556_practice,
		/datum/design/autolathe/ammo/shotgun_blanks, //shells
		/datum/design/autolathe/ammo/shotgun_flash,
		/datum/design/autolathe/ammo/stunshell,
		/datum/design/autolathe/ammo/shotgun_beanbag
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/lethal_ammo //please, maintain general order (pistol>speedloaders>smg>other>shells)+(smaller/less damaging caliber>bigger/more damaging caliber)
	disk_name = "Frozen Star Lethal Ammo Pack"
	icon_state = "frozenstar"

	license = 20
	designs = list(
		/datum/design/autolathe/ammo/mg_cl32_brute, //pistol mags
		/datum/design/autolathe/ammo/magazine_mc9mm,
		/datum/design/autolathe/ammo/magazine_c45m,
		/datum/design/autolathe/ammo/magazine_a10mm,
		/datum/design/autolathe/ammo/mg_cl44_brute,
		/datum/design/autolathe/ammo/mg_a50,
		/datum/design/autolathe/ammo/sl_c138_brute, //speed loaders
		/datum/design/autolathe/ammo/sl_cl44_brute,
		/datum/design/autolathe/ammo/magazine_sl357,
		/datum/design/autolathe/ammo/smg9mm_brute, //smg mags
		/datum/design/autolathe/ammo/magazine_mc9mmt,
		/datum/design/autolathe/ammo/c45smg_brute,
		/datum/design/autolathe/ammo/magazine_smg10mm,
		/datum/design/autolathe/ammo/SMG_sol_brute, //other mags
		/datum/design/autolathe/ammo/a556,
		/datum/design/autolathe/ammo/ih556,
		/datum/design/autolathe/ammo/c762_short,
		/datum/design/autolathe/ammo/c762_long,
		/datum/design/autolathe/ammo/shotgun_pellet, //shells
		/datum/design/autolathe/ammo/shotgun
	)


// Excelsior
/obj/item/weapon/computer_hardware/hard_drive/portable/design/excelsior
	disk_name = "Excelsior Means of Production"
	desc = "Seize it."
	icon_state = "excelsior"

	license = 0
	designs = list(
		/datum/design/autolathe/circuit/autolathe_excelsior,
		/datum/design/autolathe/circuit/shieldgen_excelsior,
		/datum/design/autolathe/circuit/reconstructor_excelsior,
		/datum/design/autolathe/circuit/diesel_excelsior,
		/datum/design/autolathe/circuit/turret_excelsior,
		/datum/design/autolathe/circuit/autolathe_disk_cloner,
		/datum/design/autolathe/device/implanter,
		/datum/design/autolathe/gun/makarov,
		/datum/design/autolathe/sec/silencer,
		/datum/design/autolathe/ammo/magazine_mc9mm,
		/datum/design/autolathe/gun/ak47,
		/datum/design/autolathe/ammo/c762_long,
		/datum/design/autolathe/ammo/box_a762,
		/datum/design/autolathe/device/excelsiormine,
		/datum/design/autolathe/sec/beartrap,
		/datum/design/autolathe/clothing/excelsior_armor,
		/datum/design/autolathe/clothing/excelsior_helmet,
		/datum/design/autolathe/cell/large/excelsior,
		/datum/design/autolathe/cell/medium/excelsior,
		/datum/design/autolathe/cell/small/excelsior,
		/datum/design/research/item/part/micro_mani,
		/datum/design/research/item/part/subspace_amplifier,
		/datum/design/research/item/part/subspace_crystal,
		/datum/design/research/item/part/subspace_transmitter,
		/datum/design/autolathe/part/igniter,
		/datum/design/autolathe/part/signaler,
		/datum/design/autolathe/part/sensor_prox,
		/datum/design/research/item/part/basic_capacitor,
		/datum/design/autolathe/part/camera_assembly
	)

/obj/item/weapon/computer_hardware/hard_drive/portable/design/excelsior_weapons
	disk_name = "Excelsior Means of Revolution"
	desc = "The back has a machine etching: \"We stand for organized terror - this should be frankly admitted. Terror is an absolute necessity during times of revolution.\""
	icon_state = "excelsior"

	license = 0
	designs = list(
		/datum/design/autolathe/gun/makarov,
		/datum/design/autolathe/sec/silencer,
		/datum/design/autolathe/ammo/magazine_mc9mm,
		/datum/design/autolathe/gun/ak47,
		/datum/design/autolathe/ammo/c762_long,
		/datum/design/autolathe/ammo/box_a762,
		/datum/design/autolathe/device/excelsiormine,
		/datum/design/autolathe/sec/beartrap,
		/datum/design/autolathe/clothing/excelsior_armor,
		/datum/design/autolathe/clothing/excelsior_helmet
	)


// One Star
/obj/item/weapon/computer_hardware/hard_drive/portable/design/onestar
	disk_name = "One Star Tool Pack"
	icon_state = "onestar"

	license = 2
	designs = list(
		/datum/design/autolathe/tool/crowbar_onestar,
		/datum/design/autolathe/tool/combi_driver_onestar,
		/datum/design/autolathe/tool/jackhammer_onestar,
		/datum/design/autolathe/tool/drill_onestar,
		/datum/design/autolathe/tool/weldertool_onestar
	)
