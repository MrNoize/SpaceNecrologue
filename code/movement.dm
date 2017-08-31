/mob/living
	var/tmp/move = 1
	var/move_debuff = 0
	var/list/obj/my_pull = list()

/mob/living/proc/calcutale_step()
	var/step_time
	if(!movement)
		step_time = (rundelay+1.5)+move_debuff
	else
		step_time = rundelay+move_debuff
	return step_time

/mob/living/Move()
	if(!isDead)
		if(!rests)
			if(stamina <= 1 && M)
				movement = 0
				M.icon_state = "movement_walk"
				return
			if(move)
				move = 0
				..()
				if(!movement)
					sleep(calcutale_step())
				else
					sleep(calcutale_step())
					stamina--
				move = 1
	else
		if(move)
			move = 0
			..()
			sleep(rundelay)
			move = 1