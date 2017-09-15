/mob/living
	var/needExp = 3
	var/exp = 0
	var/lvl = 1

/mob/living/proc/expUp(D)
	if(nature == "Teacher")
		D = D*2
	src << "<font color=purple>EXP +[D]"
	exp += D

/mob/living/proc/lvlUp()
	src << "\bold ** LEVEL UP! **"
	src << lvlup
	overlays += "lvlup"
	if(prob(25))
		ST++
		src << "\blue \bold Your strength increased."
	else if(prob(25))
		DX++
		src << "\blue \bold Your dexterity increased."
	else if(prob(25))
		EN++
		src << "\blue \bold Your endurance increased."
	else
		HP++
		src << "\blue \bold Your health increased."
	needExp += 3
	exp = 0
	lvl++
	skill_check()
	spawn(10) overlays -= "lvlup"