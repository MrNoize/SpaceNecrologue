/area
	icon = 'areas.dmi'
	layer = 50
	mouse_opacity = 0

var/list/obj/landmarks/start/locations = list()

/obj/landmarks/start
	icon = 'areas.dmi'
	icon_state = "start"
	layer = 50
	New()
		..()
		icon = null
		locations += src

/area/outside
	icon_state = "outside"
	sd_outside = 1
	New()
		..()
		icon = null