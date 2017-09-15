/mob/living
	var/meleeskill = 0
	var/miningskill = 0
	var/medskill = 0
	var/craftskill = 0
	var/parrychance = 0
	var/ST = 0
	var/EN = 0
	var/DX = 0
	var/HP = 10
	var/stamina_regen = 3

/mob/living/proc/skill_check()
	maxStamina = EN*10
	maxHealth = HP*10
	health = maxHealth
	stamina = maxStamina
	stamina_regen = EN/2
	parrychance = meleeskill*20

/mob/living/proc/skill_rand()
	meleeskill = rand(0, 2)
	craftskill = rand(0, 2)
	medskill = rand(0, 1)
	miningskill = rand(0, 2)
	ST = rand(6, 8)
	EN = rand(6, 8)
	DX = rand(6, 8)
	stamina = maxStamina
	skill_check()