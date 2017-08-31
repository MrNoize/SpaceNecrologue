/mob/living
	var/isAnimal = 0
	var/friendly = 0
	var/isUndead = 0
	var/isFrozen = 0

/mob/living/zombie
	name = "Zombie"
	icon = 'mob.dmi'
	icon_state = "zombie"
	isUndead = 1
	rundelay = 5
	New()
		zombies++
		skill_rand()
		if(prob(2))
			rundelay = 2
		if(prob(30))
			icon_state = pick("zombie_blacksuit","zombie_biohazard")
		.=..()
		spawn(1)
			zombieAI()

/mob/living/zombie/frozen
	name = "Frozen Zombie"
	icon_state = "frozen_zombie"
	rundelay = 6
	isFrozen = 1

/mob/living/proc/zhit(var/mob/living/zombie)
	if(!src.isDead && zombie.canhit && zombie.stamina >= 5 && !zombie.rests)
		if(prob(src.dexterity*4))
			view() << "\red \bold [zombie.name] попыталс[ya] ударить [src.name] когт[ya]ми!"
			view() << "\red \bold [src.name] избежал удара!"
			view() << miss
		else
			view() << "\red \bold [zombie.name] рвет плоть [src.name] своими когт[ya]ми!"
			view() << zombiehit
			src.HurtMe(max(zombie.strength*1.3, 0))
			if(zombie.isFrozen)
				move_debuff += 0.2
		zombie.stamina = max(zombie.stamina - 10, 0)
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