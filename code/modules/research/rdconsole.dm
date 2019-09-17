/*
Research and Development (R&D) Console

This is the main work horse of the R&D system. It contains the menus/controls for the Destructive Analyzer, Protolathe, and Circuit
imprinter. It also contains the /datum/research holder which handles the local research database.

Basic use: When it first is created, it will attempt to link up to related devices within 3 squares. It'll only link up if they
aren't already linked to another console. Any consoles it cannot link up with (either because all of a certain type are already
linked or there aren't any in range), you'll just not have access to that menu. In the settings menu, there are menu options that
allow a player to attempt to re-sync with nearby consoles. You can also force it to disconnect from a specific console.

The imprinting and construction menus do NOT require toxins access to access but all the other menus do. However, if you leave it
on a menu, nothing is to stop the person from using the options on that menu (although they won't be able to change to a different
one). You can also lock the console on the settings menu if you're feeling paranoid and you don't want anyone messing with it who
doesn't have toxins access.

When a R&D console is destroyed or even partially disassembled, you lose all research data on it. However, there are two ways around
this dire fate:
- The easiest way is to go to the settings menu and select "Sync Database with Network." That causes it to upload 
it's data to every other device in the game. Each console has a "disconnect from network" option that'll will cause data base sync
operations to skip that console. This is useful if you want to make a "public" R&D console or, for example, give the engineers
a circuit imprinter with certain designs on it and don't want it accidentally updating. The downside of this method is that you have
to have physical access to the other console to send data back. Note: An R&D console is on CentCom so if a random griffan happens to
cause a ton of data to be lost, an admin can go send it back.
- The second method is with data disks. Each of these disks can hold multiple technology or design datum in
it's entirety. You can then take the disk to any R&D console and upload it's data to it. This method is a lot more secure (since it
won't update every console in existence) but it's more of a hassle to do. Also, the disks can be stolen.
*/

#define SCREEN_MAIN "main"
#define SCREEN_PROTO "protolathe"
#define SCREEN_IMPRINTER "circuit_imprinter"
#define SCREEN_WORKING "working"
#define SCREEN_TREES "tech_trees"
#define SCREEN_LOCKED "locked"
#define SCREEN_DISK_DESIGNS "disk_management_designs"
#define SCREEN_DISK_TECH "disk_management_tech"

/obj/machinery/computer/rdconsole
	name = "R&D control console"
	icon_keyboard = "rd_key"
	icon_screen = "rdcomp"
	light_color = COLOR_LIGHTING_PURPLE_MACHINERY
	circuit = /obj/item/weapon/circuitboard/rdconsole
	var/datum/research/files								//Stores all the collected research data.
	var/obj/item/weapon/computer_hardware/hard_drive/portable/disk = null	//Stores the data disk.

	var/obj/machinery/r_n_d/destructive_analyzer/linked_destroy = null	//Linked Destructive Analyzer
	var/obj/machinery/r_n_d/protolathe/linked_lathe             = null	//Linked Protolathe
	var/obj/machinery/r_n_d/circuit_imprinter/linked_imprinter  = null	//Linked Circuit Imprinter

	var/screen = SCREEN_MAIN	//Which screen is currently showing.
	var/id     = 0			//ID of the computer (for server restrictions).
	var/sync   = 1		//If sync = 0, it doesn't show up on Server Control Console
	var/can_research = TRUE   //Is this console capable of researching

	req_access = list(access_moebius)	//Data and setting manipulation requires scientist access.

	var/datum/tech/selected_tech_tree
	var/datum/technology/selected_technology
	var/show_settings = FALSE
	var/show_link_menu = FALSE
	var/selected_protolathe_category
	var/selected_imprinter_category
	var/search_text

/obj/machinery/computer/rdconsole/proc/SyncRDevices() //Makes sure it is properly sync'ed up with the devices attached to it (if any).
	for(var/obj/machinery/r_n_d/D in range(3, src))
		if(!isnull(D.linked_console) || D.panel_open)
			continue
		if(istype(D, /obj/machinery/r_n_d/destructive_analyzer))
			if(isnull(linked_destroy))
				linked_destroy = D
				D.linked_console = src
		else if(istype(D, /obj/machinery/r_n_d/protolathe))
			if(isnull(linked_lathe))
				linked_lathe = D
				D.linked_console = src
		else if(istype(D, /obj/machinery/r_n_d/circuit_imprinter))
			if(isnull(linked_imprinter))
				linked_imprinter = D
				D.linked_console = src

/obj/machinery/computer/rdconsole/proc/griefProtection() //Have it automatically push research to the centcomm server so wild griffins can't fuck up R&D's work
	for(var/obj/machinery/r_n_d/server/centcom/C in SSmachines.machinery)
		C.files.download_from(files)

/obj/machinery/computer/rdconsole/Initialize()
	..()
	files = new /datum/research(src) //Setup the research data holder.
	SyncRDevices()

/obj/machinery/computer/rdconsole/Destroy()
	files = null
	if(linked_destroy)
		linked_destroy.linked_console = null
		linked_destroy = null
	if(linked_lathe)
		linked_lathe.linked_console = null
		linked_destroy = null
	if(linked_imprinter)
		linked_imprinter.linked_console = null
		linked_destroy = null
	return ..()

/obj/machinery/computer/rdconsole/attackby(var/obj/item/weapon/D as obj, var/mob/user as mob)
	//Loading a disk into it.
	if(istype(D, /obj/item/weapon/computer_hardware/hard_drive/portable))
		if(disk)
			to_chat(user, SPAN_NOTICE("A disk is already loaded into the machine."))
			return

		user.drop_item()
		D.loc = src
		disk = D
		to_chat(user, SPAN_NOTICE("You add \the [D] to the machine."))
	else if(istype(D, /obj/item/weapon/disk/research_points)) // Special disks (just normal items) that can be slapped on the console for an immediate point boost.
		var/obj/item/weapon/disk/research_points/disk = D
		to_chat(user, SPAN_NOTICE("[name] received [disk.stored_points] research points from [disk.name]."))
		files.research_points += disk.stored_points
		user.drop_item()
		qdel(disk)
	else if(istype(D, /obj/item/device/science_tool)) // Used when you want to upload autopsy/other scanned data to the console
		var/research_points = files.experiments.read_science_tool(D)
		if(research_points > 0)
			to_chat(user, SPAN_NOTICE("[name] received [research_points] research points from uploaded data."))
			files.research_points += research_points
		else
			to_chat(user, SPAN_NOTICE("There was no useful data inside [D.name]'s buffer."))
	else
		//The construction/deconstruction of the console code.
		..()

	SSnano.update_uis(src)
	return

/obj/machinery/computer/rdconsole/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		user << SPAN_NOTICE("You disable the security protocols.")
		return TRUE

/obj/machinery/computer/rdconsole/proc/reset_screen() // simply resets the screen to the main screen and updates the UIs
	screen = SCREEN_MAIN
	SSnano.update_uis(src)

/obj/machinery/computer/rdconsole/proc/handle_item_analysis(obj/item/I) // handles deconstructing items.
	files.check_item_for_tech(I)
	files.research_points += files.experiments.get_object_research_value(I)
	files.experiments.do_research_object(I)
	if(linked_lathe && I.matter)
		for(var/t in I.matter)
			if(t in linked_lathe.materials)
				linked_lathe.materials[t] += I.matter[t] * linked_destroy.decon_mod
				linked_lathe.materials[t] = min(linked_lathe.materials[t], linked_lathe.max_material_storage)

/obj/machinery/computer/rdconsole/Topic(href, href_list) // Oh boy here we go.
	if(..())
		return 1
	if(href_list["select_tech_tree"]) // User selected a tech tree.
		var/datum/tech/tech_tree = locate(href_list["select_tech_tree"]) in files.researched_tech
		if(tech_tree && tech_tree.shown)
			selected_tech_tree = tech_tree
			selected_technology = null
	if(href_list["select_technology"]) // User selected a technology node.
		var/tech_node = locate(href_list["select_technology"]) in SSresearch.all_tech_nodes
		if(tech_node)
			selected_technology = tech_node
	if(href_list["unlock_technology"]) // User attempts to unlock a technology node (Safeties are within UnlockTechnology)
		var/tech_node = locate(href_list["unlock_technology"]) in SSresearch.all_tech_nodes
		if(tech_node)
			files.UnlockTechology(tech_node)
	if(href_list["go_screen"]) // User is changing the screen.
		var/where = href_list["go_screen"]
		if(href_list["need_access"])
			if(!allowed(usr) && !emagged)
				to_chat(usr, SPAN_WARNING("Unauthorized access."))
				return
		screen = where
		if(screen == SCREEN_PROTO || screen == SCREEN_IMPRINTER)
			search_text = ""
	if(href_list["eject_disk"]) // User is ejecting the disk.
		if(disk)
			disk.forceMove(get_turf(src))
			disk = null
	if(href_list["delete_disk_design"]) // User is attempting to delete a design from the loaded disk.
		if(disk)
			var/list/disk_design_files = disk.find_files_by_type(/datum/computer_file/binary/design)
			for(var/f in disk_design_files)
				var/datum/computer_file/binary/design/design_file = f
				if("\ref[design_file.design]" == href_list["delete_disk_design"])
					disk.remove_file(design_file)
					break
	if(href_list["download_disk_design"]) // User is attempting to download (disk->rdconsole) a design from the disk.
		if(disk)
			var/list/disk_design_files = disk.find_files_by_type(/datum/computer_file/binary/design)
			for(var/f in disk_design_files)
				var/datum/computer_file/binary/design/design_file = f
				if(design_file.copy_protected)
					continue
				if("\ref[design_file.design]" == href_list["download_disk_design"])
					files.AddDesign2Known(design_file.design)
					griefProtection() //Update CentComm too
					break
	if(href_list["upload_disk_design"]) // User is attempting to upload (rdconsole->disk) a design to the disk.
		if(disk)
			var/datum/design/D = locate(href_list["upload_disk_design"]) in files.known_designs
			if(D)
				disk.store_file(D.file.clone())
	if(href_list["delete_disk_node"]) // User is attempting to delete a technology node from the disk.
		if(disk)
			var/list/disk_node_files = disk.find_files_by_type(/datum/computer_file/binary/tech)
			for(var/f in disk_node_files)
				var/datum/computer_file/binary/tech/node_file = f
				if("\ref[node_file.node]" == href_list["delete_disk_node"])
					disk.remove_file(node_file)
					break
	if(href_list["download_disk_node"]) // User is attempting to download (disk->rdconsole) a technology node from the disk.
		if(disk)
			var/list/disk_node_files = disk.find_files_by_type(/datum/computer_file/binary/tech)
			for(var/f in disk_node_files)
				var/datum/computer_file/binary/tech/node_file = f
				if("\ref[node_file.node]" == href_list["download_disk_node"])
					files.UnlockTechology(node_file.node, TRUE)
					griefProtection() //Update CentComm too
					break
	if(href_list["upload_disk_node"]) // User is attempting to upload (rdconsole->disk) a technology node to the disk.
		if(disk)
			var/datum/technology/T = locate(href_list["upload_disk_node"]) in files.researched_nodes
			if(T)
				var/datum/computer_file/binary/tech/tech_file = new
				tech_file.set_tech(T)
				disk.store_file(tech_file)
	if(href_list["toggle_settings"]) // User wants to see the settings.
		if(allowed(usr) || emagged)
			show_settings = !show_settings
		else
			to_chat(usr, SPAN_WARNING("Unauthorized access.</span>"))
	if(href_list["toggle_link_menu"]) // User wants to see the device linkage menu.
		if(allowed(usr) || emagged)
			show_link_menu = !show_link_menu
		else
			to_chat(usr, SPAN_WARNING("Unauthorized access."))
	if(href_list["sync"]) //Sync the research holder with all the R&D consoles in the game that aren't sync protected (after a 3 seconds delay).
		if(!sync)
			to_chat(usr, SPAN_WARNING("You must connect to the network first!"))
		else
			screen = SCREEN_WORKING
			griefProtection() //Putting this here because I dont trust the sync process
			addtimer(CALLBACK(src, .proc/sync_tech), 3 SECONDS)
	if(href_list["togglesync"]) //Prevents the console from being synced by other consoles. Can still send data.
		sync = !sync
	if(href_list["select_category"]) // User is selecting a design category while in the protolathe/imprinter screen
		var/what_cat = href_list["select_category"]
		if(screen == SCREEN_PROTO)
			selected_protolathe_category = what_cat
		if(screen == SCREEN_IMPRINTER)
			selected_imprinter_category = what_cat
	if(href_list["build"] && screen == SCREEN_PROTO && linked_lathe) // User wants to build something with the protolathe.
		var/amount = CLAMP(text2num(href_list["amount"]), 1, 10)
		var/datum/design/being_built = locate(href_list["build"]) in files.known_designs
		if(being_built && amount && linked_lathe)
			linked_lathe.queue_design(being_built, amount)
	if(href_list["build"] && screen == SCREEN_IMPRINTER && linked_imprinter) // User wants to build something with the imprinter.
		var/datum/design/being_built = locate(href_list["build"]) in files.known_designs
		if(being_built && linked_imprinter)
			linked_imprinter.queue_design(being_built)
	if(href_list["search"]) // User is searching for a specific design.
		var/input = sanitizeSafe(input(usr, "Enter text to search", "Searching") as null|text, MAX_LNAME_LEN)
		search_text = input
		if(screen == SCREEN_PROTO)
			if(!search_text)
				selected_protolathe_category = null
			else
				selected_protolathe_category = "Search Results"
		if(screen == SCREEN_IMPRINTER)
			if(!search_text)
				selected_imprinter_category = null
			else
				selected_imprinter_category = "Search Results"
	if(href_list["clear_queue"]) // User's clearing a queue.
		if(screen == SCREEN_PROTO && linked_lathe)
			linked_lathe.clear_queue()
		if(screen == SCREEN_IMPRINTER && linked_imprinter)
			linked_imprinter.clear_queue()
	if(href_list["deconstruct"]) // User is deconstructing an item.
		if(linked_destroy)
			if(linked_destroy.deconstruct_item())
				screen = SCREEN_WORKING // Will be resetted by the linked_destroy.
	if(href_list["eject_item"]) // User is ejecting an item from the linked_destroy.
		if(linked_destroy)
			linked_destroy.eject_item()
	if(href_list["imprinter_purgeall"] && linked_imprinter) // Purging the linked_destroy reagents
		linked_imprinter.reagents.clear_reagents()
	if(href_list["imprinter_purge"] && linked_imprinter)
		linked_imprinter.reagents.del_reagent(href_list["imprinter_purge"]) // Purging a specific reagent
	if(href_list["lathe_ejectsheet"] && linked_lathe) // Ejecting sheets from the protolathe
		var/desired_num_sheets = text2num(href_list["lathe_ejectsheet_amt"])
		linked_lathe.eject(href_list["lathe_ejectsheet"], desired_num_sheets)
	if(href_list["imprinter_ejectsheet"] && linked_imprinter) // Ejecting sheets from the imprinter
		var/desired_num_sheets = text2num(href_list["imprinter_ejectsheet_amt"])
		linked_imprinter.eject(href_list["imprinter_ejectsheet"], desired_num_sheets)
	if(href_list["find_device"]) // Connect with the local devices
		screen = SCREEN_WORKING
		addtimer(CALLBACK(src, .proc/find_devices), 2 SECONDS)
	if(href_list["disconnect"]) //The R&D console disconnects with a specific device.
		switch(href_list["disconnect"])
			if("destroy")
				linked_destroy.linked_console = null
				linked_destroy = null
			if("lathe")
				linked_lathe.linked_console = null
				linked_lathe = null
			if("imprinter")
				linked_imprinter.linked_console = null
				linked_imprinter = null
	if(href_list["reset"]) //Reset the R&D console's database.
		griefProtection()
		var/choice = alert("R&D Console Database Reset", "Are you sure you want to reset the R&D console's database? Data lost cannot be recovered.", "Continue", "Cancel")
		if(choice == "Continue")
			screen = SCREEN_WORKING
			qdel(files)
			files = new /datum/research(src)
			addtimer(CALLBACK(src, .proc/reset_screen), 2 SECONDS)
	if(href_list["lock"]) //Lock the console from use by anyone without tox access.
		if(allowed(usr) || emagged)
			screen = SCREEN_LOCKED
		else
			to_chat(usr, SPAN_WARNING("Unauthorized access."))
	if(href_list["unlock"]) // Unlock
		if(allowed(usr) || emagged)
			screen = SCREEN_MAIN
		else
			to_chat(usr, SPAN_WARNING("Unauthorized access."))

	return TRUE

/obj/machinery/computer/rdconsole/proc/find_devices()
	SyncRDevices()
	reset_screen()

/obj/machinery/computer/rdconsole/proc/sync_tech()
	for(var/obj/machinery/r_n_d/server/S in SSmachines.machinery)
		var/server_processed = FALSE
		if((id in S.id_with_upload) || istype(S, /obj/machinery/r_n_d/server/centcom))
			S.files.download_from(files)
			server_processed = TRUE
		if(((id in S.id_with_download) && !istype(S, /obj/machinery/r_n_d/server/centcom)))
			files.download_from(S.files)
			server_processed = TRUE
		if(!istype(S, /obj/machinery/r_n_d/server/centcom) && server_processed)
			S.produce_heat(100)
	reset_screen()

/obj/machinery/computer/rdconsole/proc/get_protolathe_data()
	var/list/protolathe_list = list(
		"max_material_storage" =             linked_lathe.max_material_storage,
		"total_materials" =                  linked_lathe.TotalMaterials(),
	)
	var/list/material_list = list()
	for(var/M in linked_lathe.materials)
		var/material/material = get_material_by_name(M)
		material_list += list(list(
			"id" =             M,
			"name" =           material.display_name,
			"ammount" =        linked_lathe.materials[M],
			"can_eject_one" =  linked_lathe.materials[M] >= 1,
			"can_eject_five" = linked_lathe.materials[M] >= 5,
		))
	protolathe_list["materials"] = material_list
	return protolathe_list

/obj/machinery/computer/rdconsole/proc/get_imprinter_data()
	var/list/imprinter_list = list(
		"max_material_storage" =             linked_imprinter.max_material_storage,
		"total_materials" =                  linked_imprinter.TotalMaterials(),
		"total_volume" =                     linked_imprinter.reagents.total_volume,
		"maximum_volume" =                   linked_imprinter.reagents.maximum_volume,
	)
	var/list/printer_reagent_list = list()
	for(var/datum/reagent/R in linked_imprinter.reagents.reagent_list)
		printer_reagent_list += list(list(
			"id" =             R.id,
			"name" =           R.name,
			"volume" =         R.volume,
		))
	imprinter_list["reagents"] = printer_reagent_list
	var/list/material_list = list()
	for(var/M in linked_imprinter.materials)
		var/material/material = get_material_by_name(M)
		material_list += list(list(
			"id" =             M,
			"name" =           material.display_name,
			"ammount" =        linked_imprinter.materials[M],
			"can_eject_one" =  linked_imprinter.materials[M] >= 1,
			"can_eject_five" = linked_imprinter.materials[M] >= 5,
		))
	imprinter_list["materials"] = material_list
	return imprinter_list


/obj/machinery/computer/rdconsole/proc/get_possible_designs_data(build_type, category) // Builds the design list for the UI
	var/list/designs_list = list()
	for(var/datum/design/D in files.known_designs)
		if(D.build_type & build_type)
			var/cat = "Unspecified"
			if(D.category)
				cat = D.category
			if((category == cat) || (category == "Search Results" && findtext(D.name, search_text)))
				var/temp_material
				var/temp_chemical
				var/maximum = 50
				var/can_build
				var/can_build_chem
				var/iconName = getAtomCacheFilename(D.build_path)
				for(var/M in D.materials)
					if(build_type == PROTOLATHE)
						can_build = linked_lathe.check_craftable_amount_by_material(D, M)
					if(build_type == IMPRINTER)
						can_build = linked_imprinter.check_craftable_amount_by_material(D, M)
					var/material/mat = get_material_by_name(M)
					if(can_build < 1)
						temp_material += " <span style=\"color:red\">[D.materials[M]] [mat.display_name]</span>"
					else
						temp_material += " [D.materials[M]] [mat.display_name]"
					can_build = min(can_build,maximum)
				for(var/C in D.chemicals)
					if(build_type == IMPRINTER)
						can_build_chem = linked_imprinter.check_craftable_amount_by_chemical(D, C)
					var/datum/reagent/R = chemical_reagents_list[C] // this is how you do it, you don't fucking new every possible reagent till you find a match
					if(can_build_chem < 1)
						temp_chemical += " <span style=\"color:red\">[D.chemicals[C]] [R.name]</span>"
					else
						temp_chemical += " [D.chemicals[C]] [R.name]"
					can_build = min(can_build, can_build_chem)
				designs_list += list(list(
					"id" =             "\ref[D]",
					"name" =           D.name,
					"desc" =           D.desc,
					"icon" =			iconName,
					"can_create" =     can_build,
					"temp_material" =  temp_material,
					"temp_chemical" =  temp_chemical
				))
	return designs_list

/obj/machinery/computer/rdconsole/attack_ai(mob/user)
	. = ..()
	ui_interact(user)

/obj/machinery/computer/rdconsole/attack_hand(mob/user)
	if(..())
		return
	ui_interact(user)
	

/obj/machinery/computer/rdconsole/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null) // Here we go again
	if((screen == SCREEN_PROTO && !linked_lathe) || (screen == SCREEN_IMPRINTER && !linked_imprinter))
		screen = SCREEN_MAIN // Kick us from protolathe or imprinter screen if they were destroyed

	var/list/data = list()
	data["screen"] = screen
	data["sync"] = sync
	data["has_disk"] = !!disk
	if(disk)
		data["disk_size"] = disk.max_capacity
		data["disk_used"] = disk.used_capacity
		data["disk_read_only"] = disk.read_only

	// Main screen needs info about tech levels
	if(!screen || screen == SCREEN_MAIN)
		data["show_settings"] = show_settings
		data["show_link_menu"] = show_link_menu
		data["has_dest_analyzer"] = !!linked_destroy
		data["has_protolathe"] = !!linked_lathe
		data["has_circuit_imprinter"] = !!linked_imprinter
		data["can_research"] = can_research

		var/list/tech_tree_list = list()
		for(var/tree in files.researched_tech)
			var/datum/tech/tech_tree = tree
			if(!tech_tree.shown)
				continue
			var/list/tech_tree_data = list(
				"id" =             tech_tree.type,
				"name" =           "[tech_tree.name]",
				"shortname" =      "[tech_tree.shortname]",
				"level" =          tech_tree.level,
				"maxlevel" =       tech_tree.max_level,
			)
			tech_tree_list += list(tech_tree_data)
		data[SCREEN_TREES] = tech_tree_list

		if(linked_lathe)
			data["protolathe_data"] = get_protolathe_data()

		if(linked_imprinter)
			data["imprinter_data"] = get_imprinter_data()

		if(linked_destroy)
			if(linked_destroy.loaded_item)
				// TODO: If you're refactoring origin_tech, remove this shit. Thank you from the past!
				var/list/tech_names = list("materials" = "Materials", "engineering" = "Engineering", "phorontech" = "Phoron", "powerstorage" = "Power", "bluespace" = "Blue-space", "biotech" = "Biotech", "combat" = "Combat", "magnets" = "Electromagnetic", "programming" = "Programming", "syndicate" = "Illegal")

				var/list/temp_tech = linked_destroy.loaded_item.origin_tech
				var/list/item_data = list()

				for(var/T in temp_tech)
					var/tech_name = tech_names[T]
					if(!tech_name)
						tech_name = T

					item_data += list(list(
						"id" =             T,
						"name" =           tech_name,
						"level" =          temp_tech[T],
					))

				// This calculates how much research points we missed because we already researched items with such orig_tech levels
				var/tech_points_mod = files.experiments.get_object_research_value(linked_destroy.loaded_item) / files.experiments.get_object_research_value(linked_destroy.loaded_item, ignoreRepeat = TRUE)

				var/list/destroy_list = list(
					"has_item" =              TRUE,
					"item_name" =             linked_destroy.loaded_item.name,
					"item_tech_points" =      files.experiments.get_object_research_value(linked_destroy.loaded_item),
					"item_tech_mod" =         round(tech_points_mod*100),
				)
				destroy_list["tech_data"] = item_data

				data["destroy_data"] = destroy_list
			else
				var/list/destroy_list = list(
					"has_item" =             FALSE,
				)
				data["destroy_data"] = destroy_list

	if(screen == SCREEN_DISK_DESIGNS)
		if(disk)
			var/list/disk_designs = list()
			var/list/disk_design_files = disk.find_files_by_type(/datum/computer_file/binary/design)
			for(var/design_file in disk_design_files)
				var/datum/computer_file/binary/design/d_file = design_file
				disk_designs += list(list("name" = d_file.design.name, "id" = "\ref[d_file.design]", "can_download" = !d_file.copy_protected))
			data["disk_designs"] = disk_designs
			var/list/known_designs = list()
			for(var/i in files.known_designs)
				var/datum/design/D = i
				if(!D.starts_unlocked) // doesn't make much sense to copy starting designs around.
					known_designs += list(list("name" = D.name, "id" = "\ref[D]"))
			data["known_designs"] = known_designs
	if(screen == SCREEN_DISK_TECH)
		if(disk)
			var/list/disk_tech_nodes = list()
			var/list/disk_technology_files = disk.find_files_by_type(/datum/computer_file/binary/tech)
			for(var/f in disk_technology_files)
				var/datum/computer_file/binary/tech/tech_file = f
				disk_tech_nodes += list(list("name" = tech_file.node.name, "id" = "\ref[tech_file.node]"))
			data["disk_tech_nodes"] = disk_tech_nodes
			var/list/known_nodes = list()
			for(var/i in files.researched_nodes)
				var/datum/technology/T = i
				known_nodes += list(list("name" = T.name, "id" = "\ref[T]"))
			data["known_nodes"] = known_nodes
	if(screen == SCREEN_PROTO)
		if(linked_lathe)
			data["search_text"] = search_text
			data["protolathe_data"] = get_protolathe_data()
			data["all_categories"] = files.design_categories_protolathe
			if(search_text)
				data["all_categories"] = list("Search Results") + data["all_categories"]

			if((!selected_protolathe_category || !(selected_protolathe_category in data["all_categories"])) && files.design_categories_protolathe.len)
				selected_protolathe_category = files.design_categories_protolathe[1]

			if(selected_protolathe_category)
				data["selected_category"] = selected_protolathe_category
				data["possible_designs"] = get_possible_designs_data(PROTOLATHE, selected_protolathe_category)

			var/list/queue_list = list()
			queue_list["queue"] = list()
			for(var/datum/rnd_queue_design/RNDD in linked_lathe.queue)
				queue_list["queue"] += RNDD.name
			data["queue_data"] = queue_list

	if(screen == SCREEN_IMPRINTER)
		if(linked_imprinter)
			data["search_text"] = search_text
			data["imprinter_data"] = get_imprinter_data()
			data["all_categories"] = files.design_categories_imprinter
			if(search_text)
				data["all_categories"] = list("Search Results") + data["all_categories"]

			if((!selected_imprinter_category || !(selected_imprinter_category in data["all_categories"])) && files.design_categories_imprinter.len)
				selected_imprinter_category = files.design_categories_imprinter[1]

			if(selected_imprinter_category)
				data["selected_category"] = selected_imprinter_category
				data["possible_designs"] = get_possible_designs_data(IMPRINTER, selected_imprinter_category)

			var/list/queue_list = list()
			queue_list["queue"] = list()
			for(var/datum/rnd_queue_design/RNDD in linked_imprinter.queue)
				queue_list["queue"] += RNDD.name
			data["queue_data"] = queue_list

	// All the info needed for displaying tech trees
	if(screen == SCREEN_TREES)
		var/list/line_list = list()

		var/list/tech_tree_list = list()
		for(var/tree in files.researched_tech)
			var/datum/tech/tech_tree = tree
			if(!tech_tree.shown)
				continue
			var/list/tech_tree_data = list(
				"id" =             "\ref[tech_tree]",
				"name" =           "[tech_tree.name]",
				"shortname" =      "[tech_tree.shortname]",
			)
			tech_tree_list += list(tech_tree_data)

		data["tech_trees"] = tech_tree_list

		if(!selected_tech_tree)
			selected_tech_tree = files.researched_tech[1]

		var/list/tech_list = list()
		if(selected_tech_tree)
			data["tech_tree_name"] = selected_tech_tree.name
			data["tech_tree_desc"] = selected_tech_tree.desc
			data["tech_tree_level"] = selected_tech_tree.level

			for(var/tech in SSresearch.all_tech_trees[selected_tech_tree.type])
				var/datum/technology/tech_node = tech
				var/list/tech_data = list(
					"id" =             "\ref[tech_node]",
					"name" =           "[tech_node.name]",
					"x" =              round(tech_node.x*100),
					"y" =              round(tech_node.y*100),
					"icon" =           "[tech_node.icon]",
					"isresearched" =   "[files.IsResearched(tech_node)]",
					"canresearch" =    "[files.CanResearch(tech_node)]",
					"description" =		"[tech_node.desc]"
				)
				tech_list += list(tech_data)

				for(var/req_tech in tech_node.required_technologies)
					var/datum/technology/other_tech = locate(req_tech) in SSresearch.all_tech_nodes
					if(other_tech && other_tech.tech_type == tech_node.tech_type)
						var/line_x = (min(round(other_tech.x*100), round(tech_node.x*100)))
						var/line_y = (min(round(other_tech.y*100), round(tech_node.y*100)))
						var/width = (abs(round(other_tech.x*100) - round(tech_node.x*100)))
						var/height = (abs(round(other_tech.y*100) - round(tech_node.y*100)))

						var/istop = FALSE
						if(other_tech.y > tech_node.y)
							istop = TRUE
						var/isright = FALSE
						if(other_tech.x < tech_node.x)
							isright = TRUE

						var/list/line_data = list(
							"line_x" =           line_x,
							"line_y" =           line_y,
							"width" =            width,
							"height" =           height,
							"istop" =            istop,
							"isright" =          isright,
						)
						line_list += list(line_data)

		data["techs"] = tech_list
		data["lines"] = line_list
		data["selected_tech_tree"] = "\ref[selected_tech_tree]"
		data["research_points"] = files.research_points

		data["selected_technology_id"] = ""
		if(selected_technology)
			var/datum/technology/tech_node = selected_technology
			var/list/technology_data = list(
				"name" =           tech_node.name,
				"desc" =           tech_node.desc,
				"id" =             "\ref[tech_node]",
				"tech_type" =      tech_node.tech_type,
				"cost" =           tech_node.cost,
				"isresearched" =   files.IsResearched(tech_node),
			)
			data["selected_technology_id"] = "\ref[tech_node]"

			var/list/requirement_list = list()
			for(var/t in tech_node.required_tech_levels)
				var/datum/tech/tree = locate(t) in files.researched_tech
				var/level = tech_node.required_tech_levels[t]
				var/list/req_data = list(
					"text" =           "[tree.shortname] level [level]",
					"isgood" =         (tree.level >= level)
				)
				requirement_list += list(req_data)
			for(var/t in tech_node.required_technologies)
				var/datum/technology/other_tech = locate(t) in SSresearch.all_tech_nodes
				var/list/req_data = list(
					"text" =           "[other_tech.name]",
					"isgood" =         files.IsResearched(other_tech)
				)
				requirement_list += list(req_data)
			technology_data["requirements"] = requirement_list

			var/list/unlock_list = list()
			for(var/T in tech_node.unlocks_designs)
				var/datum/design/D = locate(T) in SSresearch.all_designs
				if(D) // remove?
					var/list/build_types = list()
					if(D.build_type & IMPRINTER)
						build_types += "imprinter"
					if(D.build_type & PROTOLATHE)
						build_types += "protolathe"
					if(D.build_type & AUTOLATHE)
						build_types += "autolathe"
					if(D.build_type & MECHFAB)
						build_types += "exosuit fabricator"
					if(D.build_type & ORGAN_GROWER)
						build_types += "organ grower"
					var/list/unlock_data = list(
						"text" =           "[D.name]",
						"build_types" =		english_list(build_types, "")
					)
					unlock_list += list(unlock_data)
			technology_data["unlocks"] = unlock_list

			data["selected_technology"] = technology_data

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data)
	if (!ui)
		ui = new(user, src, ui_key, "rdconsole.tmpl", "R&D Console", 1000, 700)

		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/rdconsole/robotics
	name = "robotics R&D console"
	id = 2
	req_access = list(access_robotics)

/obj/machinery/computer/rdconsole/core
	name = "core R&D console"
	id = 1

#undef SCREEN_MAIN
#undef SCREEN_PROTO
#undef SCREEN_IMPRINTER
#undef SCREEN_WORKING
#undef SCREEN_TREES
#undef SCREEN_LOCKED