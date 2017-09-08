/obj/machinery
	icon = 'machinery.dmi'
	var/on = 1
	var/broken = 0

/obj/machinery/proc/check()

/obj/machinery/light/lamp
	icon_state = "lamp"
	luminosity = 6
	density = 1

/obj/machinery/light/lightbulb
	icon_state = "bulb1"
	luminosity = 6
	layer = 12

/obj/machinery/computer/main
	name = "main computer"
	icon_state = "maincomputer"
	density = 1
