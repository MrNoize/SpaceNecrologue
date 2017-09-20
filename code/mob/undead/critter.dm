/mob/living
	var/isAnimal = 0
	var/friendly = 0
	var/isUndead = 0
	var/isFrozen = 0
	var/isKid = 0

/mob/living/zombie
	name = "Unknown"
	icon = 'mob.dmi'
	icon_state = "zombie"
	isUndead = 1
	rundelay = 5
	act = "harm"
	nature = "Zombie"
	New()
		zombies++
		skill_rand()
		if(prob(2))
			rundelay = 2
		if(prob(20) && !isKid)
			overlays += pick("black_suit","shirt_suit","jacket_suit","pink_suit")
		.=..()
		spawn(1)
			zombieAI()

/mob/living/zombie/strong
	icon_state = "zombie+"
	rundelay = 4
	lvl = 6
	New()
		zombies++
		ST = rand(10, 13)
		EN = rand(9, 12)
		DX = rand(4, 6)
		HP = 15
		stamina = maxStamina
		skill_check()
		.=..()
		spawn(1)
			zombieAI()

/mob/living/zombie/frozen
	icon_state = "frozen_zombie"
	rundelay = 6
	isFrozen = 1

/mob/living/zombie/kid
	icon_state = "zombie_kid"
	rundelay = 3
	isKid = 1
	maxHealth = 65

/mob/living/proc/zhit(var/mob/living/zombie)
	if(!src.isDead && zombie.canhit && zombie.stamina >= 5 && !zombie.rests && zombie.key != src.key && !isUndead)
		if(prob(src.DX*4))
			msg("\red \bold [zombie.name] tries to hit [src.name] with his claws!")
			msg("\red \bold [src.name] dodges the strike!")
			playsound(miss)
		else
			msg("\red \bold [zombie.name] tears [src.name]'s flesh with his claws!")
			playsound(zombiehit)
			src.HurtMe(max(zombie.ST*1.3, 0))
			if(prob(40))
				new/obj/cleanable/blood(src.loc)
				bleeding = 1
				BloodLoss()
				msg("\red [src.name] starts bleeding!")
			if(zombie.isFrozen)
				move_debuff += 1
		zombie.stamina = max(zombie.stamina - 10, 0)
		zombie.canhit = FALSE
		spawn(7)
			zombie.canhit = TRUE

/mob/living/proc/zbite(var/mob/living/zombie)
	if(!src.isDead && zombie.canhit && !zombie.rests && zombie.key != src.key)
		if(prob(src.DX*4))
			msg("\red \bold [zombie.name] tries to bite [src.name]!")
			msg("\red \bold [src.name] dodges the bite!")
			src.expUp(1)
			playsound(miss)
		else
			msg("\red \bold [zombie.name] bites [src.name]!")
			playsound(bite)
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