/mob/living/proc/HurtMe(D)
	health = health - D
	if(D >= 10)
		if(prob(40))
			new/obj/cleanable/blood(src.loc)
			if(!isUndead)
				Me(pick("стискивает зубы", "шипит", "стонет", "вздрагивает"))
				view() << moan
	if(health <= 0)
		die()
		killed++

/mob/living/proc/HealMe(D)
	health = health + D

/mob/living/proc/die(var/mob/living/human/H = src)
	H.dropinventory()
	if(!rests)
		H.fall_down()
	if(H.client)
		H.isDead = 1
		var/mob/ghost = null
		ghost = new /mob/living/ghost(src.loc, 1)
		if(ghost)
			del(R)
			del(L)
			del(D)
			del(C)
			del(He)
			del(Re)
			del(ACT)
			del(B)
			del(E)
			del(M)
			del(P)
			ghost.key = H.key
			H.overlays = null
	else
		H.isDead = 1