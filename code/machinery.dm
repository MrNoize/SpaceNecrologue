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

/obj/machinery/vendomats/coffee
	name = "coffee machine"
	icon_state = "coffee_machine"
	density = 1
	var/canwork = 1
	var/hascharge = 3

/obj/machinery/vendomats/coffee/attack_hand(var/mob/living/H = usr)
	if(H in range(1, src))
		if(!H.acthand)
			vend(H)
		if(H.acthand)
			act_by_item(H, H.acthand)

/obj/machinery/vendomats/coffee/proc/vend(var/mob/living/user)
	if(hascharge >= 1)
		if(canwork)
			view() << "\bold[src.name] выплевывает свой продукт."
			hascharge -= 1
			new/obj/items/food/coffee(user.loc)
			canwork = 0
			spawn(50)
				canwork = 1
		else
			user << "Ќе спеши."
	else
		user << "\bold ¬ автомате недостаточно зар[ya]дников."

/obj/machinery/vendomats/coffee/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	var/obj/items/cartridge/C = I
	var/obj/items/devices/analyzer/A = I
	if(istype(C))
		view() << "\blue<B>[H.name]</B> зар[ya]жает автомат!"
		view() << click
		hascharge += C.charges
		H.cut_hands()
	if(istype(A))
		view() << "<B>[H.name]</B> сканирует <B>[src]</B>!"
		usr << "<B>ќсталось: [hascharge] зар[ya]дников.</B>"
