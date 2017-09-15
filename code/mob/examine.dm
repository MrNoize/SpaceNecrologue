/mob/living/proc/examine(var/mob/living/attacker)
	view() << "[attacker.name] looks at [src.name]."
	attacker << "\blue *--------*"
	attacker << "\blue It's <B>[src.name]</B>, [src.nature] of [lvl] level!"
	if(src.fangsOut)
		attacker << "<font color=purple>\bold He has a pair of sharp fangs, sticking out of his mouth."
	if(src.dressed)
		attacker << "\blue He has a [src.my_clothes_contents.name] on his body."
	if(src.my_rhand_contents)
		attacker << "\blue There is a [src.my_rhand_contents.name] in his right hand."
	if(src.my_lhand_contents)
		attacker << "\blue There is a [src.my_lhand_contents.name] in his left hand."
	if(src.health <= src.maxHealth/2.5)
		attacker << "\red \bold He is heavily wounded."
	if(src.calories <= 50)
		attacker << "\red He is severely malnourished."
	if(src.bleeding)
		attacker << "\red \bold He is bleeding."
	if(src.blood <= 50)
		attacker << "\red He looks pale."
	if(src.ST > attacker.ST)
		attacker << "\red He looks stronger than you."
	if(src.act == "help")
		attacker << "\blue He looks pretty friendly."
	else
		attacker << "\red \bold He looks aggressive"
	attacker << "\blue *--------*"