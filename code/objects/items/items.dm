/obj/items
	icon = 'items.dmi'

/obj/items/devices/analyzer
	name = "analyzer"
	icon_state = "analyzer"

/obj/items/battery
	name = "battery"
	icon_state = "battery"
	var/energystored = 800

/obj/items/modules/st_cb
	name = "standart circuit board"
	icon_state = "st_cb"

/obj/items/cartridge
	name = "cartridge"
	icon_state = "cartridge"
	var/charges = 10

/obj/items/metal
	name = "scrap metal"
	icon_state = "metal1"
	New()
		icon_state = "metal[pick("1","2")]"

/obj/items/devices/demolisher
	name = "demolisher device"
	icon_state = "demolisher"
	var/charge = 5

/obj/items/devices/demolisher/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	var/obj/items/cartridge/C = I
	var/obj/items/devices/analyzer/A = I
	if(istype(C))
		view() << "<B>[H.name]</B> charges [src]!"
		view() << click
		charge += C.charges
		usr << "<B>Demolisher has [charge] charges left зар[ya]дов.</B>"
		H.cut_hands()
	if(istype(A))
		view() << "<B>[H.name]</B> scans <B>[src.name]</B>!"
		usr << "<B>Charges left: [charge]</B>"

