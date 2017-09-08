/obj/items/metal/act_by_item(var/mob/living/H, var/obj/items/metal/M)
	if(istype(M))
		if(prob(H.craftskill*30))
			view() << "\bold[H.name] creates the girder!"
			new/obj/structures/girder(src.loc)
		else
			view() << "\bold[H.name] broke the materials!"
		H.cut_hands()
		del src

/obj/items/weapon/bat/lucille/act_by_item(var/mob/living/H, var/obj/items/I)
	if(istype(I) && H.canhit)
		view() << "\bold \blue[H.name] pets [src.name] with [I.name]."

/obj/items/weapon/bat/act_by_item(var/mob/living/H, var/obj/items/metal/M)
	if(istype(M))
		if(prob(H.craftskill*30))
			view() << "\bold[H.name] modifies [src]!"
			new/obj/items/weapon/bat/lucille(src.loc)
		else
			view() << "\bold[H.name] broke the materials!"
		H.cut_hands()
		del src

/obj/items/modules/st_cb/act_by_item(var/mob/living/H, var/obj/items/battery/B)
	if(istype(B))
		if(prob(H.craftskill*30))
			view() << "\bold[H.name] creates a cartridge!"
			new/obj/items/cartridge(src.loc)
		else
			view() << "\bold[H.name] broke the materials!"
		H.cut_hands()
		del src

/obj/items/weapon/plank/act_by_item(var/mob/living/H, var/obj/items/weapon/plank/P)
	if(istype(P))
		if(prob(H.craftskill*30))
			view() << "\bold[H.name] creates a baseball bat!"
			new/obj/items/weapon/bat(src.loc)
		else
			view() << "\bold[H.name] broke the materials!"
		H.cut_hands()
		del src



