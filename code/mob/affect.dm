/obj/items/food/proc/consume(var/mob/living/H = usr)
	if(units > 0 && H.calories < 300 && !H.isVampire)
		msg("\red \bold [H.name] consumes [src.name]!")
		playsound(eat)
		units--
		if(nutriments)
			H.calories += nutriments
		if(units <= 0)
			H.cut_hands()
		if(H.blood < 100)
			H.blood += 10
		if(mining)
			H.lvlUp()
			H.miningskill++
			H << "\blue \bold You learned something new about mining!"
		if(melee)
			H.lvlUp()
			H.meleeskill++
			H << "\blue \bold You learned something new about fights!"
		if(medicine)
			H.lvlUp()
			H.medskill++
			H << "\blue \bold You learned something new about medicine!"
		if(craft)
			H.lvlUp()
			H.craftskill++
			H << "\blue \bold You learned something new about crafting!"
		if(velocity && H.move_debuff > 0)
			H.move_debuff = 0
			H << "\blue You feel yourself fast again."
	else
		usr << "\bold \red I can't eat anymore..."