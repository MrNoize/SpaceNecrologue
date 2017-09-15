/mob/living
	var/cantalk = 1
	var/rests = 0
	var/dressed = 0
	var/isDead = 0
	var/calories = 300
	var/stamina
	var/maxStamina = 100
	var/canhit = 1
	var/mymob = ""
	var/spawnlocation = ""
	layer = 5

/mob/living/Stat(var/mob/living/H = usr)
	..()
	if(statpanel("Status"))
		stat(null, "ST: [ST]")
		stat(null, "EN: [EN]")
		stat(null, "DX: [DX]")
		stat(null, "HP: [HP]")
		if(isVampire)
			stat(null, "Blood: [blood]")
		stat(null, "Calories: [calories]")
		stat(null, "Stamina: [stamina]")
		stat(null, "Exp: [exp]/[needExp]")
		stat(null, "Daytime: [daytime]")

/mob/living/verb/check()
	set name = "About Me"
	set category = "IC"
	usr << "<B>*---------*</B>"
	usr << "<B>STATS:</B>"
	usr << "<B><font color=purple>ST - [ST]</B>"
	usr << "<B><font color=purple>EN - [EN]</B>"
	usr << "<B><font color=purple>DX - [DX]</B>"
	usr << "<B><font color=purple>HP - [HP]</B>"
	usr << "<B>About me:</B>"
	if(meleeskill > 0)
		usr << "<B><font color=purple>Melee - [meleeskill]</B>"
	if(miningskill > 0)
		usr << "<B><font color=purple>Mining - [miningskill]</B>"
	if(medskill > 0)
		usr << "\bold <font color=purple>Medicine - [medskill]"
	if(craftskill > 0)
		usr << "<B><font color=purple>Engineering - [craftskill]</B>"
	usr << "<B>*---------*</B>"

/mob/living/ghost
	isDead = 1
	density = 0
	movement = 1

/mob/living/proc/health()
	if(!isDead)
		spawn(0.1)
			health()
		if(health >= maxHealth)
			He.icon_state = "health10"
		if(health <= maxHealth/1.1)
			He.icon_state = "health9"
		if(health <= maxHealth/1.2)
			He.icon_state = "health8"
		if(health <= maxHealth/1.4)
			He.icon_state = "health7"
		if(health <= maxHealth/1.6)
			He.icon_state = "health6"
		if(health <= maxHealth/2)
			He.icon_state = "health5"
		if(health <= maxHealth/2.5)
			He.icon_state = "health4"
		if(health <= maxHealth/3.3)
			He.icon_state = "health3"
		if(health <= maxHealth/5)
			He.icon_state = "health2"
		if(health <= maxHealth/10)
			He.icon_state = "health1"
		if(health <= maxHealth-maxHealth)
			He.icon_state = "health0"

proc/mob_controller()
	for(var/mob/living/M in world)
		if(!M.isDead)
			if(M.stamina < M.maxStamina)
				M.stamina += M.stamina_regen
				if(M.stamina > M.maxStamina)
					M.stamina = M.maxStamina
			if(M.health < M.maxHealth && M.calories > 250 && !M.isUndead)
				M.health += 0.2
			if(!M.isUndead && M.blood < 100 && M.calories > 250)
				M.blood += 2
			if(M.health > M.maxHealth)
				M.health = M.maxHealth
			if(M.health <= 0 && !M.rests)
				M.fall_down()
			if(M.blood <= 0)
				M.fall_down()
				M.blood = 0
			if(M.blood > 100)
				M.blood = 100
			if(M.exp >= M.needExp)
				M.lvlUp()
			if(M.isVampire)
				M.calories = 0
			M.life()

/mob/living/proc/life()
	if(!isDead && health > 0 && calories != 0 && !isUndead && !isVampire)
		if(nature == "Athlete")
			calories -= 2
		else
			calories--
		sleep(10)
	if(isVampire)
		blood--
		sleep(20)
	if(calories <= 0 && !isDead && !isUndead && !isVampire)
		HurtMe(0.2)
		stamina--
		if(prob(15))
			usr << "\red *I'm so damn hungry...*"
	if(isUndead && ckey)
		if(prob(5))
			Me("moans")
			view() << sound(pick('sounds/zombie_life1.ogg', 'sounds/zombie_life2.ogg', 'sounds/zombie_life3.ogg'))
	if(!isDead && blood <= 50)
		HurtMe(0.2)
		stamina--
		if(prob(10))
			usr << "\red *I feel faint...*"
	if(health < 0)
		health = 0
	if(stamina < 0)
		stamina = 0
	if(!dressed && !isUndead)
		try_to_cold(30)

/mob/living/var/canrest = 1

/mob/living/verb/rest()
	set name = "Rest"
	set category = "IC"
	if(!isDead && canrest && health > 0)
		if(!rests)
			fall_down()
			canrest = 0
			spawn(10)
				canrest = 1
		else
			view() << "\blue<B>[src.name]</B> stands up."
			canrest = 0
			sleep(10)
			if(health > 0)
				var/matrix/Ma = matrix()
				rests = 0
				Ma.Turn(360)
				transform = Ma
				if(key)
					Re.icon_state = "rest_up"
				density = 1
				spawn(10)
					canrest = 1

/mob/living/proc/fall_down()
	if(!rests)
		var/matrix/Ma = matrix()
		Ma.Turn(90)
		transform = Ma
		view() << "<B>[src.name]</B> falls on the ground!"
		if(key)
			Re.icon_state = "rest_down"
		rests = 1
		density = 0