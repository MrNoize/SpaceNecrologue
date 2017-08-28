/obj/items
	icon = 'items.dmi'

/obj/items/devices/analyzer
	name = "analyzer"
	icon_state = "analyzer"

/obj/items/battery
	name = "battery"
	icon_state = "battery"
	var/energystored = 800

/obj/items/cartridge
	name = "cartridge"
	icon_state = "cartridge"
	var/charges = 10

/obj/items/metal
	name = "scrap metal"
	icon_state = "metal"

/obj/items/devices/demolisher
	name = "demolisher device"
	icon_state = "demolisher"
	var/charge = 5

/obj/items/devices/demolisher/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	if(H in range(1, src))
		var/obj/items/cartridge/C = I
		var/obj/items/devices/analyzer/A = I
		if(istype(C))
			view() << "<B>[H.name]</B> зар[ya]жает демолишер!"
			view() << click
			charge += C.charges
			usr << "<B>Теперь демолишер содержит в себе [charge] зар[ya]дов.</B>"
			H.cut_hands()
			del C
		if(istype(A))
			view() << "<B>[H.name]</B> сканирует <B>[src.name]</B>!"
			usr << "<B>Зар[ya]д: [charge]</B>"

