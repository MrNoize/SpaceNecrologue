/obj/machinery/vendomats
	var/canwork = 1
	var/hascharge = 3
	var/loot = ""

/obj/machinery/vendomats/coffee
	name = "Coffee Machine"
	icon_state = "coffee_machine"
	density = 1
	loot = /obj/items/food/coffee

/obj/machinery/vendomats/attack_hand(var/mob/living/H = usr)
	if(H in range(1, src))
		if(!H.acthand)
			vend(H)
		if(H.acthand)
			act_by_item(H, H.acthand)

/obj/machinery/vendomats/proc/vend(var/mob/living/user)
	if(hascharge >= 1)
		if(canwork)
			view() << "\bold[src.name] выдает свой продукт."
			hascharge -= 1
			new loot(user.loc)
			canwork = 0
			spawn(50)
				canwork = 1
		else
			user << "Не спеши."
	else
		user << "\bold В автомате недостаточно зар[ya]дников."

/obj/machinery/vendomats/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	var/obj/items/cartridge/C = I
	var/obj/items/devices/analyzer/A = I
	if(istype(C))
		view() << "\blue<B>[H.name]</B> зар[ya]жает автомат!"
		view() << click
		hascharge += C.charges
		H.cut_hands()
	if(istype(A))
		view() << "<B>[H.name]</B> сканирует <B>[src]</B>!"
		usr << "<B>Осталось: [hascharge] зар[ya]дников.</B>"