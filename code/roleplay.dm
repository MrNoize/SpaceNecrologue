/mob/living/verb/say(msg as text)
	set name = "Say"
	set category = "IC"
	if(cantalk)
		if(!msg)
			return
		else
			for(var/mob/M in view())
				msg = fix255(msg)
				M << "<B>[usr]</B> говорит, \"[msg]\""

//EMOTE//
/mob/living
	var/canEmote = 1

/mob/living/verb/sigh()
	set name = "Sigh"
	set category = "Emote"
	if(canEmote)
		Me("вздыхает")
		view() << sigh
		canEmote = FALSE
		spawn(30)
			canEmote = TRUE

/mob/living/verb/laugh()
	set name = "Laugh"
	set category = "Emote"
	if(canEmote)
		Me("смеетс€")
		view() << sound(pick('sounds/laugh_1.ogg','sounds/laugh_2.ogg','sounds/laugh_3.ogg'))
		canEmote = FALSE
		spawn(30)
			canEmote = TRUE

//EMOTE//

/mob/verb/OOC(msg as text)
	set category = "OOC"
	msg = fix255(msg)
	if(ooc)
		if(!msg) return
		else
			world << "<B>\blue OOC: [key]: [msg]</B>"
	else
		usr << "<B>\red Ќедоступно.</B>"

/mob/living/verb/Me(msg as text)
	set category = "IC"
	msg = fix255(msg)
	if(!msg) return
	else
		view() << "<B>[src.name]</B> [msg].</B>"