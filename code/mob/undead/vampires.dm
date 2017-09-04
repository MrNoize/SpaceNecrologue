/mob/living
	var/isVampire = 0
	var/fangsOut = 0
	var/invisible = 0

/mob/living/proc/vampire_check()
	if(isVampire && !isDead)
		usr << "\bold \red You're a vampire."
		usr.verbs+=new/mob/living/vampire/verb/invis
		usr.verbs+=new/mob/living/vampire/verb/regeneration
		usr.verbs+=new/mob/living/vampire/verb/blood_strength
		usr.verbs+=new/mob/living/vampire/verb/fangs

/mob/living/vampire/verb/fangs()
	set category = "Vampire"
	set name = "Fangs"
	if(!fangsOut)
		fangsOut = 1
		view() << fangs
		view() << "<B>[src.name]</B> reveals his gigantic fangs!"
	else
		fangsOut = 0
		view() << fangs
		view() << "<B>[src.name]</B> hides his fangs."

/mob/living/vampire/verb/invis()
	set category = "Vampire"
	set name = "Reflection (10)"
	if(blood >= 10)
		blood -= 10
		alpha = 5
		invisible = 1
		view() << discipline
		spawn(300)
			alpha = 255
			invisible = 0
	else
		usr << "\red Not enough blood."

/mob/living/vampire/verb/blood_strength()
	set category = "Vampire"
	set name = "Blood Strength (30)"
	if(blood >= 30)
		blood -= 30
		view() << discipline
		strength += 5
		endurance += 3
		rundelay += 1
		skill_check()
		usr << "\bold You feel much stronger."
		spawn(500)
			usr << "\bold You're weak again."
			strength -= 5
			if(prob(20))
				strength -= 1
				move_debuff += 1
			endurance -= 3
			rundelay -= 1
			skill_check()
	else
		usr << "\red Not enough blood."

/mob/living/vampire/verb/regeneration()
	set category = "Vampire"
	set name = "Recovery (20)"
	if(blood >= 20)
		if(health < 100)
			health += 40
			usr << "\red Some of your wounds have been healed."
		if(bleeding)
			bleeding = 0
			usr << "\blue The bleeding has stopped."
		blood -= 20
		view() << discipline
	else
		usr << "<B>\red Not enough blood.</B>"
