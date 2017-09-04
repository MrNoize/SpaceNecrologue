/mob/living
	var/isAnimal = 0
	var/friendly = 0
	var/isUndead = 0
	var/isFrozen = 0

/mob/living/zombie
	icon = 'mob.dmi'
	icon_state = "zombie"
	isUndead = 1
	rundelay = 5
	act = "harm"
	New()
		name_pick()
		zombies++
		skill_rand()
		if(prob(2))
			rundelay = 2
		if(prob(30) && !isFrozen)
			icon_state = pick("zombie_blacksuit","zombie_biohazard")
		.=..()
		spawn(1)
			zombieAI()

/mob/living/zombie/frozen
	icon_state = "frozen_zombie"
	rundelay = 6
	isFrozen = 1

/mob/living/proc/zhit(var/mob/living/zombie)
	if(!src.isDead && zombie.canhit && zombie.stamina >= 5 && !zombie.rests && zombie.key != src.key && !isUndead)
		if(prob(src.dexterity*4))
			view() << "\red \bold [zombie.name] tries to hit [src.name] with his claws!"
			view() << "\red \bold [src.name] dodges the strike!"
			view() << miss
		else
			view() << "\red \bold [zombie.name] tears [src.name]'s flesh with his claws!"
			view() << zombiehit
			src.HurtMe(max(zombie.strength*1.3, 0))
			if(prob(40))
				new/obj/cleanable/blood(src.loc)
				bleeding = 1
				BloodLoss()
				view() << "\red [src.name] starts bleeding!"
			if(zombie.isFrozen)
				move_debuff += 1
		zombie.stamina = max(zombie.stamina - 10, 0)
		zombie.canhit = FALSE
		spawn(7)
			zombie.canhit = TRUE

/mob/living/proc/zbite(var/mob/living/zombie)
	if(!src.isDead && zombie.canhit && !zombie.rests && zombie.key != src.key)
		if(prob(src.dexterity*4))
			view() << "\red \bold [zombie.name] tries to bite [src.name]!"
			view() << "\red \bold [src.name] dodges the bite!"
			view() << miss
		else
			view() << "\red \bold [zombie.name] bites [src.name]!"
			view() << bite
			if(prob(40))
				src.isBitten = 1
				virus(src)
			src.HurtMe(8)
			zombie.canhit = FALSE
			spawn(7)
				zombie.canhit = TRUE

/mob/living/skeleton
	name = "Skeleton"
	icon = 'mob.dmi'
	icon_state = "skeleton"
	isUndead = 1
	rundelay = 3
	New()
		skill_rand()
		.=..()
		spawn(1)
			hostileAI()