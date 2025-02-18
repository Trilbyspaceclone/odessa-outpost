/obj/item/weapon/circuitboard/atmoscontrol
	name = "\improper Central Atmospherics Computer Circuitboard"
	build_path = /obj/machinery/computer/atmoscontrol

/obj/machinery/computer/atmoscontrol
	name = "\improper central atmospherics computer"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "generic_key"
	icon_screen = "comm_logs"
	light_color = COLOR_LIGHTING_BLUE_MACHINERY
	density = 1
	anchored = 1.0
	circuit = /obj/item/weapon/circuitboard/atmoscontrol
	req_access = list(access_ce)
	var/list/monitored_alarm_ids = null
	var/datum/nano_module/atmos_control/atmos_control

/obj/machinery/computer/atmoscontrol/laptop
	name = "atmospherics laptop"
	desc = "A cheap laptop."
	icon_state = "laptop"
	icon_keyboard = "laptop_key"
	icon_screen = "atmoslaptop"
	density = 0
	CheckFaceFlag = 0

/obj/machinery/computer/atmoscontrol/attack_ai(var/mob/user as mob)
	ui_interact(user)

/obj/machinery/computer/atmoscontrol/attack_hand(mob/user)
	if(..())
		return 1
	ui_interact(user)

/obj/machinery/computer/atmoscontrol/emag_act(var/remaining_carges, var/mob/user)
	if(!emagged)
		user.visible_message(SPAN_WARNING("\The [user] does something \the [src], causing the screen to flash!"),\
			SPAN_WARNING("You cause the screen to flash as you gain full control."),\
			"You hear an electronic warble.")
		atmos_control.emagged = 1
		return 1

/obj/machinery/computer/atmoscontrol/ui_interact(var/mob/user)
	if(!atmos_control)
		atmos_control = new(src, req_access, req_one_access, monitored_alarm_ids)
	atmos_control.ui_interact(user)
