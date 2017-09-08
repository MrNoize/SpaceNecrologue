/obj/structures
	icon = 'structures.dmi'
	density = 1
	var/destructible = 0
	var/health = 100
	var/hitsound
	var/breaksound
	var/loot

/obj/structures/attack_hand(var/mob/living/H)
	if(H in range(1, src))
		if(H.acthand)
			act_by_item(H, H.acthand)

/obj/structures/proc/zact(var/mob/living/Z)
	var/turf/T = src.loc
	if(Z.canhit && destructible)
		view() << "\red<B>[Z.name]</B> hits <B>[src]</B>!"
		view() << hitsound
		health -= Z.strength*4
		Z.canhit = FALSE
		spawn(10)
			Z.canhit = TRUE
	if(health <= 0)
		Z.canhit = TRUE
		new loot(T)
		del src

/obj/structures/act_by_item(var/mob/living/H, var/obj/items/weapon/W)
	var/turf/T = src.loc
	if(istype(W) && H.canhit && destructible && !H.invisible)
		view() << "\red<B>[H.name]</B> hits <B>[src]</B>!"
		view() << hitsound
		health -= W.power*1.5
		H.canhit = FALSE
		spawn(10)
			H.canhit = TRUE
	if(health <= 0)
		H.canhit = TRUE
		new loot(T)
		del src

/obj/structures/bed
	name = "bed"
	icon_state = "bed"
	density = 0

/obj/structures/rack
	name = "rack"
	icon_state = "rack"

/obj/structures/rack/attack_hand(var/mob/living/H = usr)
	if(H in range(1, src))
		if(H.acthand)
			act_by_item(H, H.acthand)

/obj/structures/rack/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	if(H.act == "help")
		I.loc = src.loc
		H.cut_hands()
		I.layer = 4

/obj/structures/grille
	name = "grille"
	icon_state = "grille"
	destructible = 1
	hitsound = 'sounds/grillehit.ogg'
	loot = /obj/items/metal

/obj/structures/planks
	name = "wooden plank"
	icon_state = "boarded"
	destructible = 1
	layer = 14
	density = 1
	hitsound = 'sounds/bang.ogg'
	loot = /obj/items/weapon/plank

/turf/simulated/wall/window
	name = "window"
	icon_state = "window"
	layer = 4
	opacity = 0
	var/opened = 0
	attack_hand(var/mob/living/H)
		if(H in range(1, src))
			if(!H.acthand && !H.isDead)
				if(!opened)
					view() << "\bold[H.name] opens the window!"
					icon_state = "window_opened"
					density = 0
					opened = 1
				else
					view() << "\bold[H.name] closes the window!"
					icon_state = "window"
					density = 1
					opened = 0
			if(H.acthand && !H.isDead)
				act_by_item(H, H.acthand)
	act_by_item(var/mob/living/H, var/obj/items/weapon/W)
		var/obj/items/weapon/plank/P = W
		if(istype(P))
			view() << "\bold[H.name] nails the board to the window!"
			view() << deconstruct
			new/obj/structures/planks(src)
			H.cut_hands()
	New()
		..()
		var/area/A = loc
		if(A.sd_outside)
			sd_light_spill_turfs += src

/obj/structures/tires
	name = "pile of tires"
	icon_state = "tires"

/obj/structures/table
	name = "table"
	icon_state = "table"

/obj/structures/table/attack_hand(var/mob/living/H = usr)
	if(H in range(1, src))
		if(!H.acthand && H.act == "harm" && H.loc != src.loc)
			view() << "\bold[H.name] jumps on the table!"
			H.loc = src.loc
		if(H.acthand)
			act_by_item(H, H.acthand)

/obj/structures/table/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	if(H.act == "help")
		I.loc = src.loc
		H.cut_hands()
		I.layer = 4

/obj/structures/chair
	name = "chair"
	icon_state = "chair"
	density = 0

/obj/structures/girder
	name = "girder"
	icon = 'turfs.dmi'
	icon_state = "girder"
	density = 1
	layer = 8
	attack_hand(var/mob/living/H = usr)
		if(H in range(1, src))
			var/turf/T = src.loc
			if(H.acthand)
				var/obj/items/metal/M = H.acthand
				var/obj/items/weapon/shard/S = H.acthand
				var/obj/items/weapon/plank/P = H.acthand
				if(istype(P))
					view() << "\bold[H.name] creates a wall!"
					view() << deconstruct
					new/turf/simulated/wall/wooden(T)
					H.cut_hands()
					del src
				if(istype(M))
					view() << "\bold[H.name] creates a wall!"
					view() << deconstruct
					new/turf/simulated/wall(T)
					H.cut_hands()
					del src
				if(istype(S))
					view() << "\bold[H.name] creates a window!"
					view() << deconstruct
					new/turf/simulated/wall/window(T)
					H.cut_hands()
					del src