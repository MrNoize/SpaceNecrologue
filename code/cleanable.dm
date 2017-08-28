/obj/cleanable
	icon = 'cleanable.dmi'
	layer = 2

/obj/cleanable/attack_hand(var/mob/living/H = usr)
	var/obj/items/weapon/mop/M = H.acthand
	if(H in range(1, src))
		if(H.acthand && istype(M))
			view() << "\blue<B>[H.name]</B> вытирает пол швабронькой!"
			cleaned += 1
			del src

/obj/cleanable/blood
	name = "blood"
	icon_state = "blood1"
	New()
		icon_state = "blood[pick("1","2","3")]"

/obj/cleanable/trash
	name = "trash"
	icon_state = "trash1"
	New()
		icon_state = "trash[pick("1","2","3","4","5","6","7","8","9")]"

/obj/cleanable/greenglow
	name = "dirt"
	icon_state = "greenglow"