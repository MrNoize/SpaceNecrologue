/mob/living
	var/isVampire = 0
	var/fangsOut = 0
	var/invisible = 0

/mob/living/proc/vampire_check()
	if(isVampire && !isDead)
		usr << "\bold \red You're a vampire."
		usr.verbs+=new/mob/living/vampire/verb/invis
		usr.verbs+=new/mob/living/vampire/verb/regeneration
		usr.verbs+=new/mob/living/vampire/verb/blood_ST
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
		alpha = 0
		invisible = 1
		usr << discipline
		spawn(300)
			alpha = 255
			invisible = 0
	else
		usr << "\red Not enough blood."

/mob/living/vampire/verb/blood_ST()
	set category = "Vampire"
	set name = "Blood Strength (30)"
	if(blood >= 30)
		blood -= 30
		usr << discipline
		ST += 5
		EN += 3
		rundelay += 1
		skill_check()
		usr << "\bold You feel much stronger."
		spawn(500)
			usr << "\bold You're weak again."
			ST -= 5
			if(prob(20))
				ST -= 1
				move_debuff += 0.5
			EN -= 3
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
		if(move_debuff > 0)
			move_debuff = 0
			usr << "\blue You feel yourself fast again."
		blood -= 20
		usr << discipline
	else
		usr << "<B>\red Not enough blood.</B>"
