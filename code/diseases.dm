/mob/living
	var/isBitten = 0

/mob/living/proc/try_to_cold()
	if(prob(30))
		freeze()

/mob/living/proc/freeze()
	if(!isDead)
		HurtMe(0.1)
		if(prob(30))
			usr << "\red *Я замерзаю...*"

