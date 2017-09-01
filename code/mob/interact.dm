/atom/Click(location,control,params,var/mob/living/H = src)
	params = params2list(params)
	if("right" in params)
		if(istype(H) && H in range(1, usr))
			H.push(usr)
	if("left" in params)
		var/mob/living/U = usr
		var/obj/structures/S = src
		if(src in range(1, U))
			if(!U.isUndead)
				attack_hand(usr)
			else
				if(istype(H))
					if(prob(80))
						H.zhit(U)
					else
						H.zbite(U)
				if(istype(S))
					S.zact(U)
	if("middle" in params)
		var/mob/living/Us = usr
		if(!Us.fotgof)
			var/mob/living/U = usr
			U.swap_hands()
		else
			if(istype(H) && H in range(1, usr))
				H.push(usr)

/atom/proc/act_by_item(var/mob/living/H = usr, var/obj/items/I)

/atom/proc/attack_hand(var/mob/living/H = usr)
	if(!H.isDead)
		if(src in range(1, H))
			if(istype(src, /obj/items))
				var/obj/items/I = src
				if(H.hand && !H.my_rhand_contents)
					H.my_rhand_contents = src
					I.Move(usr)
					layer = MOB_LAYER + 51
					H.R.overlays += src
				if(!H.hand && !H.my_lhand_contents)
					H.my_lhand_contents = src
					I.Move(usr)
					layer = MOB_LAYER + 51
					H.L.overlays += src
				if(H.hand && H.my_rhand_contents)
					act_by_item(usr, H.my_rhand_contents)
				if(!H.hand && H.my_lhand_contents)
					act_by_item(usr, H.my_lhand_contents)
			else
				act_by_item(usr, H.acthand)

/mob/living/proc/dropinventory()
	if(my_rhand_contents)
		var/obj/items/I = my_rhand_contents
		I.Move(src.loc)
		I.layer = 4
		my_rhand_contents = null
	if(my_lhand_contents)
		var/obj/items/I = my_lhand_contents
		I.Move(src.loc)
		I.layer = 4
		my_lhand_contents = null
	if(my_clothes_contents)
		var/obj/items/clothing/C = my_clothes_contents
		C.Move(src.loc)
		C.layer = 4
		my_clothes_contents = null
	if(my_pocket_contents)
		var/obj/items/I = my_pocket_contents
		I.Move(src.loc)
		I.layer = 4
		my_pocket_contents = null
	if(my_belt_contents)
		var/obj/items/I = my_belt_contents
		I.Move(src.loc)
		I.layer = 4
		my_belt_contents = null

/mob/living/proc/drop(var/mob/living/H = usr)
	if(H.acthand && !H.isDead)
		var/obj/items/I = H.acthand
		H.cut_hands()
		I.Move(usr.loc)
		I.layer = 5

/mob/living/attack_hand(var/mob/living/H = usr)
	if(H in range(1, src))
		if(!H.isDead)
			if(!H.acthand && H.act == "harm")
				if(!H.fangsOut)
					src.hit(usr)
				else
					src.bloodsuck(usr)
			if(!H.acthand && H.act == "help")
				view() << "\blue <B>[H.name]</B> ����������� <B>[src.name]</B>!"
			if(H.acthand)
				act_by_item(H, H.acthand)

/mob/living/act_by_item(var/mob/living/H = usr, var/obj/items/I)
	var/obj/items/weapon/W = I
	var/obj/items/devices/analyzer/A = I
	var/obj/items/drugs/D = I
	if(istype(W) && H.act == "harm")
		weaponhit(usr, H.acthand)
	if(istype(D) && H.act == "help")
		healhit(usr, H.acthand)
	if(istype(W) && H.act == "help")
		view() << "\blue <B>[H.name]</B> ������� � [W.name]!"
	if(istype(A))
		view() << "\blue <B>[H.name]</B> ��������� <B>[src.name]</B>!"
		usr << "\blue ��������: [src.health]"
		usr << "\blue ������� �����: [src.blood]%"
		if(src.bleeding)
			usr << "\red \bold ���������� ������������."

/mob/living/proc/push(var/mob/living/attacker)
	if(!src.isDead && !attacker.isDead && attacker.canhit && attacker.stamina >= 10 && !rests && attacker.ckey != src.ckey)
		if(prob(src.dexterity*3) && !src.isUndead)
			view() << "\red \bold [src.name] ���������� [attacker.name]!"
			attacker.push(src)
		else
			view() << "\red \bold [attacker.name] ������� [src.name]!"
			fall_down()
			attacker.stamina -= 10
			attacker.canhit = FALSE
			spawn(7)
				attacker.canhit = TRUE

/mob/living/proc/bloodsuck(var/mob/living/attacker)
	if(!attacker.isDead && attacker.canhit && attacker.ckey != src.ckey)
		if(prob(src.dexterity*5) && !src.isUndead)
			view() << "\red \bold [attacker.name] ��������[ya] ������� [src.name]!"
			view() << "\red \bold [src.name] ������� �����!"
			view() << miss
		else
			if(src.blood > 0)
				view() << "\red \bold [attacker.name] ������ [src.name] �� ���!"
				view() << bloodsuck
				attacker.blood += 15
				src.blood -= 15
				attacker.canhit = FALSE
				spawn(30)
					attacker.canhit = TRUE
			else
				attacker << "� �������� ������������ �����."

/mob/living/proc/hit(var/mob/living/attacker)
	if(!src.isDead && attacker.canhit && attacker.stamina >= 5)
		if(prob(src.dexterity*4) && !src.isUndead && attacker.ckey != src.ckey)
			view() << "\red \bold [attacker.name] ��������[ya] ������� [src.name]!"
			view() << "\red \bold [src.name] ������� �����!"
			view() << miss
		else
			view() << "\red \bold [attacker.name] ���� [src.name] �������!"
			view() << sound(pick('sounds/punch1.ogg','sounds/punch2.ogg','sounds/punch3.ogg'))
			src.HurtMe(max(attacker.strength*1.3, 0))
			if(!attacker.isUndead)
				attacker.calories -= 2
			if(prob(5+attacker.strength) && !rests)
				view() << "\red \bold ����������� ����!"
				src.HurtMe(10)
				src.fall_down()
			if(src.isUndead && src.target != attacker)
				view() << "[src.name] ������� �� [attacker.name]."
				src.target = attacker
		attacker.stamina = max(attacker.stamina - 10, 0)
		attacker.canhit = FALSE
		spawn(7)
			attacker.canhit = TRUE

/mob/living/proc/healhit(var/mob/living/attacker, var/obj/items/drugs/D)
	if(!src.isDead && src.health < 100)
		if(D.units > 0)
			view() << "\blue \bold [attacker.name] ���������� [D.name] �� [src.name]!"
			src.HealMe(D.hp+attacker.medskill*3)
			D.units -= 1
			if(D.units <= 0)
				cut_hands()
			if(D.isBandage && src.bleeding)
				bleeding = 0
				src << "\blue ������������ ������������."
			attacker << "\bold �������� [D.units] �������������."
	else
		attacker << "\bold �� ������."

/mob/living/proc/weaponhit(var/mob/living/attacker, var/obj/items/weapon/W)
	if(!src.isDead && canhit && attacker.stamina >= 10)
		if(prob(src.parrychance + src.dexterity))
			if(attacker.ckey != src.ckey && !src.isUndead)
				view() << "\red \bold [src.name] �������� [attacker.name]!"
				view() << parry
				canhit = FALSE
				src.stamina -= 5
				attacker.stamina -= 10
				spawn(10)
					canhit = TRUE
		else
			view() << "\red \bold [attacker.name] ���� [src.name] � ������� [W.name]!"
			soundpick(attacker,W)
			view() << attacker.attacksound
			src.HurtMe(max(W.power*attacker.strength/5, 0))
			if(!attacker.isUndead)
				attacker.calories -= 2
			if(prob(5+attacker.strength) && !rests)
				view() << "\red \bold ����������� ����!"
				src.HurtMe(10)
				src.fall_down()
			if(src.isUndead && src.target != attacker)
				view() << "[src.name] ������� �� [attacker.name]."
				src.target = attacker
			canhit = FALSE
			attacker.stamina -= 10
			spawn(10)
				canhit = TRUE

/mob/living/proc/eclothes(var/mob/living/H = usr)
	if(H.acthand && !H.my_clothes_contents)
		var/obj/items/clothing/I = H.acthand
		if(istype(I))
			H.C.overlays += I
			H.my_clothes_contents = I
			view() << "\blue <B>[H.name]</B> �������� <B>[I.name]</B>."
			I.layer = MOB_LAYER + 51
			H.overlays += I.texture
			H.dressed = 1
			H.cut_hands()

/mob/living/proc/cunequip(var/mob/living/H = usr)
	if(H.my_clothes_contents)
		if(H.hand && !H.my_rhand_contents)
			var/obj/items/clothing/I = H.my_clothes_contents
			if(istype(I))
				H.R.overlays += I
				H.my_rhand_contents = I
				I.layer = MOB_LAYER + 51
				H.overlays -= I.texture
				H.dressed = 0
				H.C.overlays -= I
				H.my_clothes_contents = null
		if(!H.hand && !H.my_lhand_contents)
			var/obj/items/clothing/I = H.my_clothes_contents
			if(istype(I))
				H.L.overlays += I
				H.my_lhand_contents = I
				I.layer = MOB_LAYER + 51
				H.overlays -= I.texture
				H.dressed = 0
				H.C.overlays -= I
				H.my_clothes_contents = null
		if(H.my_pocket_contents)
			var/obj/items/I = H.my_pocket_contents
			P.overlays -= I
			H.my_pocket_contents = null
			I.Move(src.loc)
			I.layer = 4
		if(H.my_belt_contents)
			var/obj/items/I = H.my_belt_contents
			B.overlays -= I
			H.my_belt_contents = null
			I.Move(src.loc)
			I.layer = 4

/mob/living/proc/epocket(var/mob/living/H = usr)
	if(H.acthand && !H.my_pocket_contents)
		var/obj/items/I = H.acthand
		if(istype(I))
			H.P.overlays += I
			H.my_pocket_contents = I
			view() << "<B>[H.name]</B> ���-�� ���� � ���� ������."
			I.layer = MOB_LAYER + 51
			H.cut_hands()

/mob/living/proc/upocket(var/mob/living/H = usr)
	if(H.hand && !H.my_rhand_contents && H.my_pocket_contents)
		var/obj/items/I = H.my_pocket_contents
		H.R.overlays += I
		H.my_rhand_contents = I
		I.layer = MOB_LAYER + 51
		H.P.overlays -= I
		H.my_pocket_contents = null
	if(!H.hand && !H.my_lhand_contents && H.my_pocket_contents)
		var/obj/items/I = H.my_pocket_contents
		H.L.overlays += I
		H.my_lhand_contents = I
		I.layer = MOB_LAYER + 51
		H.P.overlays -= I
		H.my_pocket_contents = null

/mob/living/proc/ebelt(var/mob/living/H = usr)
	if(H.acthand && !H.my_belt_contents)
		var/obj/items/I = H.acthand
		if(istype(I))
			H.B.overlays += I
			H.my_belt_contents = I
			I.layer = MOB_LAYER + 51
			H.cut_hands()

/mob/living/proc/ubelt(var/mob/living/H = usr)
	if(H.hand && !H.my_rhand_contents && H.my_belt_contents)
		var/obj/items/I = H.my_belt_contents
		H.R.overlays += I
		H.my_rhand_contents = I
		I.layer = MOB_LAYER + 51
		H.B.overlays -= I
		H.my_belt_contents = null
	if(!H.hand && !H.my_lhand_contents && H.my_belt_contents)
		var/obj/items/I = H.my_belt_contents
		H.L.overlays += I
		H.my_lhand_contents = I
		I.layer = MOB_LAYER + 51
		H.B.overlays -= I
		H.my_belt_contents = null