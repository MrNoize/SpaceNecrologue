/mob/living
	var/meleeskill = 0
	var/miningskill = 0
	var/medskill = 0
	var/craftskill = 0
	var/parrychance = 0
	var/strength = 0
	var/endurance = 0
	var/dexterity = 0
	var/stamina_regen = 3

/mob/living/proc/skill_check()
	stamina_max = endurance*10
	stamina = stamina_max
	stamina_regen = endurance/2
	parrychance = meleeskill*20

/mob/living/proc/skill_rand()
	meleeskill = rand(0, 2)
	craftskill = rand(0, 2)
	medskill = rand(0, 1)
	miningskill = rand(0, 2)
	strength = rand(5, 8)
	endurance = rand(5, 8)
	dexterity = rand(5, 8)
	stamina = stamina_max
	skill_check()