var/delay = 0
/mob/living/var/currentArea = ""

/mob/living
	Bump(var/obj/machinery/doors/D)
		if(istype(D) && D.closed && !D.working && !D.broken && !isDead)
			D.proceed(src)

/obj/machinery/doors
	icon = 'doors.dmi'
	var/mydoor = ""
	var/mysound
	var/powered = 0
	var/closed = 1
	var/locked = 0
	var/working = 0
	var/med = 0
	var/eng = 0
	var/needspower = 1
	var/transparent = 0
	density = 1
	opacity = 1
	layer = 5
	New()
		if(transparent)
			opacity = 0

/obj/machinery/doors/attack_hand(var/mob/living/user)
	if(user in range(1, src))
		if(!user.acthand && !user.isDead)
			proceed()
		if(user.acthand && !user.isDead)
			act_by_item(user, user.acthand)

/obj/machinery/doors/act_by_item(var/mob/living/user, var/obj/items/I)
	var/obj/items/weapon/screwdriver/S = I
	var/obj/items/weapon/plank/P = I
	if(istype(P))
		view() << "\bold[user.name] nails the board to the [src.name]!"
		view() << deconstruct
		new/obj/structures/planks(src.loc)
		user.cut_hands()
	if(istype(S))
		if(broken)
			if(prob(user.craftskill*30))
				view() << "<B>[user.name]</B> fixes the door!</B>"
				broken = 0
			else
				view() << "\red<B>CRITICAL FAILURE! [user.name] breaks the screwdriver!</B>"
				user.cut_hands()

/obj/machinery/doors/proc/try_to_break()
	if(prob(1))
		view() << "<B>[src.name]</B> breaks!"
		broken = 1

/obj/machinery/doors/proc/proceed(var/mob/living/user = usr)
	if(!broken)
		if(!working)
			if(closed)
				flick("[mydoor]_opening", src)
				view() << mysound
				working = 1
				sleep(6)
				open()
				try_to_break()
			else
				flick("[mydoor]_closing", src)
				view() << mysound
				working = 1
				sleep(6)
				close()
				try_to_break()

	else
		usr << "<B>Won't budge.</B>"

/obj/machinery/doors/proc/open()
	icon_state = "[mydoor]_opened"
	closed = 0
	density = 0
	opacity = 0
	working = 0

/obj/machinery/doors/proc/close()
	icon_state = "[mydoor]_closed"
	closed = 1
	working = 0
	density = 1
	if(!transparent)
		opacity = 1
	else
		opacity = 0

/obj/machinery/doors/futuristic
	name = "futuristic door"
	icon_state = "futuristic_closed"
	mydoor = "futuristic"
	mysound = 'sounds/airlock.ogg'
	transparent = 1

/obj/machinery/doors/spiral
	name = "futuristic door"
	icon_state = "spiral_closed"
	mydoor = "spiral"
	mysound = 'sounds/airlock.ogg'

/obj/machinery/doors/cage
	name = "cage"
	icon_state = "cage_closed"
	mydoor = "cage"
	mysound = 'sounds/cage.ogg'
	transparent = 1

/obj/machinery/doors/house
	name = "door"
	icon_state = "house_closed"
	mydoor = "house"
	mysound = 'sounds/housedoor.ogg'

/obj/machinery/doors/store
	name = "store door"
	icon_state = "store_closed"
	mydoor = "store"
	mysound = 'sounds/storedoor.ogg'
	transparent = 1