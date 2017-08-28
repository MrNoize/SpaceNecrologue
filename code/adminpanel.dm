/mob/verb/adminverbs_c()
	set category = "OOC"
	set name = "Candy"
	if(usr.key == "difilex" || usr.key == "Difilex")
		GM_check()
	else
		src << "Ћизь."

/mob/proc/GM_check()
	usr << "<B>Х Ѕип буп.</B>"
	usr.verbs+=new/mob/admin/verb/End
	usr.verbs+=new/mob/admin/verb/Announce
	usr.verbs+=new/mob/admin/verb/disableOOC

var/autoreboot = 0
var/reboottime = 0

mob/admin/verb/End()
	set category = "Admin"
	world.End()

mob/admin/verb/disableOOC()
	set category = "Admin"
	set name = "Disable OOC"
	if(ooc)
		world << "<B>OOC вырубили!</B>"
		ooc = 0
	else
		world << "<B>OOC врубили!</B>"
		ooc = 1

mob/admin/verb/Announce(message as message)
	set category = "Admin"
	set name = "Announce"
	if(message)
		for(var/client/C)
			C.mob << "<center><br><b><font color=red>[message] - [ckey]</font></center>"
	else
		usr << "<B>Ѕуп.</B>"

proc/autostuff()
	if(!reboottime)
		return
	spawn(reboottime)
		if(!reboottime)
			return
		autoreboot = 1
		world<<"<b><font color = red>FUCK WHAT IS GOING ON."
		spawn(250)
			world << "<b><font color = red>5!"
			sleep(10)
			world << "<b><font color = red>4!"
			sleep(10)
			world << "<b><font color = red>3!"
			sleep(10)
			world << "<b><font color = red>2!"
			sleep(10)
			world << "<b><font color = red>1!"
			sleep(10)
			if(autoreboot)
				world.Reboot()