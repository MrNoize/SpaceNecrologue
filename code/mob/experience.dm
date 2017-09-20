/mob/living
	var/needExp = 2
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
	pick(STUP(),DXUP(),ENUP(),HPUP())
	needExp += 2
	exp = 0
	lvl++
	skill_check()
	spawn(10) overlays -= "lvlup"

/mob/living/proc/STUP()
	ST++
	src << "\blue \bold Your strength increased."

/mob/living/proc/DXUP()
	DX++
	src << "\blue \bold Your dexterity increased."

/mob/living/proc/ENUP()
	EN++
	src << "\blue \bold Your endurance increased."

/mob/living/proc/HPUP()
	HP++
	src << "\blue \bold Your health increased."