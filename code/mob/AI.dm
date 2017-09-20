/mob/living/var/mob/living/target

/mob/living/proc/animalAI()
	if(!src.isDead)
		if(!target)
			step_rand(src)
		if(target && !src.isDead && !target.isDead)
			rundelay = 2
			step_away(src, target, 7)
		sleep(rundelay*time_scale)
		spawn()	animalAI()

/mob/living/proc/zombieAI()
	if(!isDead)
		if(target in range(10, src))
			if(!target.isDead && !target.isUndead && !target.invisible)
				if(get_dist(src, target) > 1)
					step_to(src, target, 0, 10)
					sleep(rundelay*time_scale)
				else
					if(prob(95))
						target.zhit(src)
					else
						target.zbite(src)
					sleep(rundelay*time_scale)
			else
				target = null
				sleep(rundelay*time_scale)
				step_rand(src)
		else
			get_target()
			step_rand(src)
			if(target)
				sleep(1)
			else
				step_rand(src)
				sleep(rundelay)
		sleep(rundelay*time_scale)
		if(prob(10))
			playsound(pick('sounds/zombie_life1.ogg', 'sounds/zombie_life2.ogg', 'sounds/zombie_life3.ogg'))
		if(rests)
			rest()
		if(isFrozen)
			for(var/mob/living/H in oview(3, src))
				H.try_to_cold(50)
		spawn() zombieAI()

/mob/living/proc/hostileAI()
	if(!isDead)
		if(target in range(14, src))
			if(!target.isDead && !target.invisible)
				if(get_dist(src, target) > 1)
					step_to(src, target, 0, 10)
					sleep(rundelay*time_scale)
				else
					target.hit(src)
					sleep(rundelay*time_scale)
			else
				target = null
				sleep(rundelay*time_scale)
				step_rand(src)
		else
			get_target()
			if(target)
				sleep(1)
			else
				step_rand(src)
				sleep(rundelay)
		sleep(rundelay*time_scale)
		if(rests)
			rest()
		spawn() hostileAI()

/mob/living/proc/get_target()
	for(var/mob/living/H in oview(5, src))
		if(!H.isUndead && !H.invisible)
			target = H
			return