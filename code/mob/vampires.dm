/mob/living
	var/isVampire = 0
	var/fangsOut = 0

/mob/living/proc/vampire_check()
	if(isVampire && !isDead)
		usr << "\bold \red �� - ������."
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
		view() << "<B>[src.name]</B> �������� �������� �����!"
	else
		fangsOut = 0
		view() << fangs
		view() << "<B>[src.name]</B> ��[ya]��� �����."

/mob/living/vampire/verb/invis()
	set category = "Vampire"
	set name = "Reflection (10)"
	if(blood >= 10)
		blood -= 10
		alpha = 5
		view() << discipline
		spawn(500)
			alpha = 255
	else
		usr << "\red ������������ �����."

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
		usr << "\bold �� ���������� ���[ya] � ���� �������."
		spawn(500)
			usr << "\bold �� ����� ����."
			strength -= 5
			if(prob(20))
				strength -= 1
				move_debuff += 1
			endurance -= 3
			rundelay -= 1
			skill_check()
	else
		usr << "\red ������������ �����."

/mob/living/vampire/verb/regeneration()
	set category = "Vampire"
	set name = "Recovery (20)"
	if(blood >= 20)
		if(health < 100)
			health += 40
			usr << "\red ����� ��� �� ���� ���� ���[ya]������."
		if(bleeding)
			bleeding = 0
			usr << "\blue ������������ ������������."
		blood -= 20
		view() << discipline
	else
		usr << "<B>\red ������������ �����.</B>"
