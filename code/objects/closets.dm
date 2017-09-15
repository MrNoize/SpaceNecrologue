var/global/list/objects = list()

/obj/structures/closets
	icon = 'closets.dmi'
	var/closed = 1
	var/mycloset = ""
	var/transparent = 0
	var/transfull = 0
	var/list/obj/item/container = list()
	density = 1
	layer = 2
	New()
		var/turf/T = src.loc
		for(var/obj/items/I in T)
			I.Move(src)

/obj/structures/closets/cabinet
	name = "cabinet"
	icon_state = "cabinet_closed"
	mycloset = "cabinet"
	transparent = 1

/obj/structures/closets/hatch
	name = "hatch"
	icon_state = "hatch_closed"
	mycloset = "hatch"
	transfull = 1
	density = 0

/obj/structures/closets/toilet
	name = "toilet"
	icon_state = "toilet_closed"
	mycloset = "toilet"
	transparent = 1

/obj/structures/closets/fridge
	name = "fridge"
	icon_state = "fridge_closed"
	mycloset = "fridge"

/obj/structures/closets/closet
	name = "closet"
	icon_state = "closet_closed"
	mycloset = "closet"
	transparent = 1

/obj/structures/closets/trashcart
	name = "trash cart"
	icon_state = "trashcart_closed"
	mycloset = "trashcart"

/obj/structures/closets/attack_hand(var/mob/living/H)
	if(H in range(1, src))
		if(!H.acthand && !H.isDead)
			proceed()
		if(H.acthand && !H.isDead)
			act_by_item(H, H.acthand)

/obj/structures/closets/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	if(!closed)
		I.loc = src.loc
		H.cut_hands()
		I.layer = 4
	else
		proceed()

/obj/structures/closets/proc/proceed()
	view() << sound('sounds/click.ogg')
	if(closed)
		open()
	else
		close()

/obj/structures/closets/proc/open()
	icon_state = "[mycloset]_opened"
	closed = 0
	if(transparent || transfull)
		density = 0
	for(var/obj/items/I in contents)
		I.Move(src.loc)

/obj/structures/closets/proc/close()
	icon_state = "[mycloset]_closed"
	closed = 1
	if(!transfull || !transparent)
		density = 1
	var/turf/T = src.loc
	for(var/obj/items/I in T)
		I.Move(src)