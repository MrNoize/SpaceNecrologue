/mob/living
	var/isBitten = 0

/mob/living/proc/try_to_cold(C)
	if(prob(C))
		freeze(src)

/mob/living/proc/freeze(var/mob/living/F)
	if(!isDead && !isUndead && !isVampire)
		HurtMe(1)
		if(prob(30))
			if(canEmote)
				F << "\red *Я замерзаю...*"
				F.Me("кашляет")
				view() << cough
				canEmote = FALSE
				spawn(30)
					canEmote = TRUE

/mob/living/proc/virus(var/mob/living/V)
	if(!V.isDead && !V.isUndead && !V.isVampire && V.isBitten)
		spawn(600)
			V.icon_state = "zombie"
			V.rundelay = 5
			V.isUndead = 1
			V.isBitten = 0


