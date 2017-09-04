/obj/items/metal/act_by_item(var/mob/living/H, var/obj/items/metal/M)
	if(istype(M))
		if(prob(H.craftskill*30))
			view() << "\bold[H.name] creates the girder!"
			new/obj/structures/girder(src.loc)
		else
			view() << "\bold[H.name] broke the materials!"
		H.cut_hands()
		del src



