world
	name = "Space Necrologue"
	fps = 30
	icon_size = 32
	view = 7

/world/New()
	sd_SetDarkIcon('light.dmi',7)
	countLight()
	spawn(1) DemoDayCycle()
	master_controller()
	world << "\red \bold Было создано:"
	world << "\red[zombies] зомби."
	world << "\red[lightsources] источников света."

mob
	step_size = 32
	var/rundelay = 2

obj
	step_size = 32

/world/mob = /mob/default

proc/master_controller()
	mob_controller()
	var/r = rand(10, 20)
	sleep(r*time_scale)
	spawn() master_controller()

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
   usr << "<B>Мальчики:</B>"
   for(M)
      if(M.client)
         usr << M.key















