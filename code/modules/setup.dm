world
	name = "Space Necrologue"
	fps = 30
	icon_size = 32
	view = 7

/world/New()
	sd_SetDarkIcon('light.dmi',7)
	colorize()
	countLight()
	spawn(1) DemoDayCycle()
	master_controller()
	world << "\red \bold We created:"
	world << "\red[zombies] zombies."
	world << "\red[lightsources] light sources."

mob
	step_size = 32
	var/rundelay = 2

client/show_popup_menus = 0

obj
	step_size = 32

/world/mob = /mob/default

proc/master_controller()
	mob_controller()
	spawn(10) master_controller()

atom/proc/process()
	spawn while(1)
		sleep(10)
		return

var/ya = "&#255;"
var/ooc = 1
var/time_scale = 1
var/lobby = 1

mob/verb/Who()
   set category = "OOC"
   var/mob/M
   usr << "<B>Boys:</B>"
   for(M)
      if(M.client)
         usr << M.key















