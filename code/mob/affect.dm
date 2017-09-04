/obj/items/food/proc/consume(var/mob/living/H = usr)
	if(units > 0 && H.calories < 300 && !H.isVampire)
		view() << "\red \bold [H.name] consumes [src.name]!"
		view() << eat
		units--
		if(nutriments)
			H.calories += nutriments
		if(units <= 0)
			H.cut_hands()
		if(H.blood < 100)
			H.blood += 10
		if(velocity && H.move_debuff > 0)
			H.move_debuff = 0
			H << "\blue You feel yourself fast again."
	else
		usr << "\bold \red I can't eat anymore..."