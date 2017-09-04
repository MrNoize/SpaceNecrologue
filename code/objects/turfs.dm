/turf
	icon = 'turfs.dmi'

/turf/unsimulated/dirt
	name = "ground"
	icon_state = "dirt"
	New()
		dir = dir8()
		if(prob(2))
			new /obj/structures/bush(src)
		if(prob(1))
			new /obj/items/metal(src)
		if(prob(1))
			new /turf/unsimulated/rock(src)
		if(prob(1))
			new /mob/living/zombie(src)
		if(prob(0.1))
			new /mob/living/zombie/frozen(src)
		if(prob(0.5))
			new /obj/structures/bush/berries(src)
		if(prob(1))
			new /obj/items/food/krasnogrib(src)
		if(prob(0.5))
			new /obj/items/food/boletus(src)

/turf/unsimulated/dirt/road
	icon_state = "dirtroad"

/turf/simulated/floor/road
	name = "road"
	icon_state = "road"
	New()
		dir = dir4()
		if(prob(1))
			new /obj/cleanable/blood(src)

/turf/simulated/floor
	name = "floor"
	icon_state = "floor"
	New()
		if(prob(1))
			new /obj/cleanable/trash(src)

/turf/simulated/floor/plating
	name = "plating"
	icon_state = "plating"

/turf/simulated/floor/wood
	name = "wooden floor"
	icon_state = "wood"
	New()
		dir = dir8()
		if(prob(1))
			new /obj/cleanable/greenglow(src)

/turf/simulated/wall
	name = "wall"
	icon_state = "wall"
	density = 1
	opacity = 1
	layer = 8
	attack_hand(var/mob/living/H = usr)
		if(H in range(1, src))
			if(H.acthand)
				act_by_item(H, H.acthand)

/turf/simulated/wall/wooden
	name = "wooden wall"
	icon_state = "woodenwall"

/turf/unsimulated/rock
	name = "rock"
	icon_state = "rock"
	density = 1
	opacity = 1
	var/health = 100
	New()
		dir = dir4()
	attack_hand(var/mob/living/H = usr)
		if(!H.isDead && H.acthand && H.canhit && H.stamina >= 5)
			var/obj/items/weapon/pickaxe/P = H.acthand
			if(istype(P))
				view() << "\red \bold[H.name] hits [src.name] with his pickaxe!"
				view() << pickaxe
				health -= P.power+H.strength
				H.stamina -= 5
				H.calories -= 5
				if(health <= 0)
					new /turf/unsimulated/dirt(src)
					H.canhit = TRUE
				if(prob(10))
					new /obj/items/metal(src)
				H.canhit = FALSE
				spawn(10)
					H.canhit = TRUE