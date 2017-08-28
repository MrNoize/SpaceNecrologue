var/global/cleaned = 0
var/global/zombies = 0
var/global/killed = 0
var/global/lightsources

world/proc/End()
	autoreboot = 1
	world << "<b><font size=3>• Конец дн[ya].</font></B>"
	sleep(20)
	world << "<B><font size=2>Ужасающие последстви[ya]:</font></B>"
	world << "<B>Гр[ya]зьки убрано:</B> [cleaned]"
	world << "<B>Убито:</B> [killed]"
	world << "<b><font color = red>Рестарт через 30 секунд."
	sleep(300)
	if(autoreboot)
		world.Reboot()

proc/countLight()
	for(var/obj/machinery/light/L in world)
		lightsources++
