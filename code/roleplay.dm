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

/mob/verb/OOC(msg as text)
	set category = "OOC"
	msg = fix255(msg)
	if(ooc)
		if(!msg) return
		else
			world << "<B>\blue OOC: [key]: [msg]</B>"
	else
		usr << "<B>\red Недоступно.</B>"

/mob/living/verb/Me(msg as text)
	set category = "IC"
	msg = fix255(msg)
	if(!msg) return
	else
		view() << "<B>[src.name]</B> [msg].</B>"