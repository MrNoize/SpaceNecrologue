/mob/living
	var/isBitten = 0

/mob/living/proc/try_to_cold(C)
	if(prob(C))
		freeze(src)

/mob/living/proc/freeze(var/mob/living/F)
	if(!isDead && !isUndead)
		HurtMe(1)
		if(prob(30))
			if(canEmote)
				F << "\red *Я замерзаю...*"
				F.Me("кашляет")
				view() << cough
				canEmote = FALSE
				spawn(30)
					canEmote = TRUE

