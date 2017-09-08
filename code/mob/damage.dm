/mob/living
	var/health
	var/maxHealth = 100
	var/bleeding = 0
	var/blood = 100

/mob/living/proc/HurtMe(D)
	health = health - D
	if(D >= 10 && prob(40))
		if(!isUndead)
			Me("moans")
			view() << moan
	if(health <= 0)
		die()

/mob/living/proc/BloodLoss()
	if(bleeding && blood > 0)
		blood -= 1
		HurtMe(0.3)
		if(prob(50))
			new/obj/cleanable/blood(src.loc)
		spawn(20) BloodLoss()

/mob/living/proc/HealMe(D)
	health = health + D

/mob/living/proc/die(var/mob/living/human/H = src)
	killed++
	dropinventory()
	if(!rests)
		H.fall_down()
	if(isUndead)
		zombies--
	if(H.client)
		H.isDead = 1
		var/mob/ghost = null
		ghost = new /mob/living/ghost(src.loc, 1)
		if(ghost)
			del_hud()
			ghost.key = H.key
	else
		H.isDead = 1