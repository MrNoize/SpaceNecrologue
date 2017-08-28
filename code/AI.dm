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
		if(target in range(14, src))
			if(!target.isDead)
				if(get_dist(src, target) > 1)
					step_to(src, target, 0, 10)
					sleep(rundelay*time_scale)
				else
					target.zhit(src)
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
		if(prob(10))
			view() << sound(pick('sounds/zombie_life1.ogg', 'sounds/zombie_life2.ogg', 'sounds/zombie_life3.ogg'))
		if(rests)
			rest()
		spawn() zombieAI()

/mob/living/proc/hostileAI()
	if(!isDead)
		if(target in range(14, src))
			if(!target.isDead)
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
	for(var/mob/living/H in oview(6, src))
		if(!H.isUndead)
			target = H
			return