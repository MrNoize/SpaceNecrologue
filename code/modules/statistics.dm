var/global/cleaned = 0
var/global/zombies = 0
var/global/killed = 0
var/global/lightsources

world/proc/End()
	autoreboot = 1
	world << "<b><font size=3>• End of the day.</font></B>"
	sleep(20)
	world << "<B><font size=2>Horrifying consequences:</font></B>"
	world << "<B>Cleaned up dirt:</B> [cleaned]"
	world << "<B>Killed:</B> [killed]"
	world << "<b><font color = red>Restart in 30 seconds."
	sleep(300)
	if(autoreboot)
		world.Reboot()

proc/countLight()
	for(var/obj/machinery/light/L in world)
		lightsources++
