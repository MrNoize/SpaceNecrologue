/obj/items/food/proc/consume(var/mob/living/H = usr)
	if(units > 0)
		if(H.calories < 300)
			view() << "\red \bold [H.name] ������ [src.name]!"
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
				H << "\blue �� ����� ���������� ���[ya] �������."
		else
			usr << "\bold \red �� ����� ������ ������..."