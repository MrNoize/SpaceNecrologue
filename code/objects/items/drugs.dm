/obj/items/drugs
	icon = 'chem.dmi'
	var/hp = 0
	var/units = 3
	var/isBandage = 0

/obj/items/drugs/ointment
	name = "ointment"
	icon_state = "ointment"
	hp = 20

/obj/items/drugs/bandage
	name = "bandage"
	icon_state = "bandage"
	isBandage = 1
	hp = 10

/obj/items/drugs/bandage/cloth
	name = "cloth"
	icon_state = "cloth"
	units = 1
