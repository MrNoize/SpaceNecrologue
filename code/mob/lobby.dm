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

/mob/living
	var/nature

/mob/living/human/proc/nature_pick()
	var/pick = input("Choose your nature") in list("Snob", "Punk", "Teacher", "Oldtimer", "Athlete") as text|null
	if(pick)
		switch(pick)
			if("Snob")
				DX += 4
				usr.overlays += "snob_face"
				nature = "Snob"
			if("Teacher")
				rundelay -= 0.3
				usr.overlays += "teacher_face"
				craftskill += 2
				miningskill += 2
				medskill += 2
				nature = "Teacher"
			if("Oldtimer")
				rundelay += 0.5
				usr.overlays += "oldtimer_face"
				craftskill++
				miningskill++
				medskill++
				nature = "Oldtimer"
			if("Athlete")
				rundelay -= 0.3
				usr.overlays += "athlete_face"
				ST++
				EN += 2
				nature = "Athlete"
			if("Punk")
				usr.overlays += "punk_face"
				meleeskill++
				DX++
				EN++
				nature = "Punk"