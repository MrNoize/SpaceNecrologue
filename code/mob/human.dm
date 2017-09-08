/mob/living/human
	icon = 'mob.dmi'
	icon_state = "human"
	mymob = "human"
	Login()
		skill_rand()
		name_pick()
		nature_pick()
		draw_hud()
		process()
		hud_processor()
		if(prob(15))
			isVampire = 1
			vampire_check()
		health()
		skill_check()
		x = pick(5,15,25)
		y = 4
		z = 1

/mob/living/verb/respawn()
	set name = "Respawn"
	set category = "OOC"
	if(client && isDead)
		var/mob/default = null
		default = new /mob/default(locate(/turf/menu))
		if(default)
			default.key = src.key
			default.name = default.key
			overlays = null
	else
		usr << "\red \bold You need to die first."