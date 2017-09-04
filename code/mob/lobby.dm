/turf/menu
	icon_state = "plating"
	luminosity = 10

/mob/living/proc/name_pick()
	var/f_name = pick("Ivan", "Urist", "Cliff", "Rick", "Shlyfer", "Carl", "Randy", "Daniel", "Oscar", "Ottar", "Colton", "Dagon", "Michael", "Jew", "Darius", "Luther", "John", "Junkie", "Hooman", "Yurka", "Heh")
	var/l_name = pick("Rambold", "McDwarf", "Ratfucker", "Grimes", "Shepard", "Smith", "Hitler", "Cobb", "Robustovich", "Shulgin", "Shaleez", "Rana", "Krasnogribov", "Stalin", "Huang")
	src.name = "[f_name] [l_name]"

/mob/default/Login()
	loc = locate(/turf/menu)

/mob/default/verb/Join_Game()
	set name = "Join Game"
	set category = "Lobby"
	join_game()

/mob/default/proc/join_game()
	var/mob/living/human/char = null
	char = new /mob/living/human
	if(char)
		char.key = src.key
		del(src)

/mob/living/human/proc/nature_pick()
	var/pick = input("Choose your nature") in list("Snob", "Oldtimer", "Athlete") as text|null
	if(pick)
		switch(pick)
			if("Snob")
				dexterity++
				usr.overlays += "snob_face"
			if("Oldtimer")
				move_debuff += 0.5
				usr.overlays += "oldtimer_face"
				craftskill++
				miningskill++
			if("Athlete")
				rundelay -= 0.2
				usr.overlays += "athlete_face"
				strength++
				endurance++