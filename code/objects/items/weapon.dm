/obj/items/weapon
	var/power = 0
	var/sharp = 0
	var/attacktype
	var/attacklog

/obj/items/weapon/screwdriver
	name = "screwdriver"
	icon_state = "screwdriver"
	power = 10
	sharp = 1
	attacktype = "stab"
	attacklog = "stabs"

/obj/items/weapon/plank
	name = "wooden plank"
	icon_state = "wood"
	power = 9
	attacktype = "hit"
	attacklog = "hits"

/obj/items/weapon/hatchet
	name = "hatchet"
	icon_state = "hatchet"
	power = 15
	attacktype = "slash"
	attacklog = "chops"

/obj/items/weapon/knife
	name = "kitchen knife"
	icon_state = "knife"
	power = 13
	sharp = 1
	attacktype = "slash"
	attacklog = "cuts"

/obj/items/weapon/pickaxe
	name = "pickaxe"
	icon_state = "pickaxe"
	power = 14
	sharp = 1
	attacktype = "hit"
	attacklog = "hits"

/obj/items/weapon/bat
	name = "baseball bat"
	icon_state = "bat"
	power = 15
	attacktype = "hit"
	attacklog = "hits"

/obj/items/weapon/bat/lucille
	name = "lucille"
	icon_state = "lucille"
	power = 19

/obj/items/weapon/crowbar
	name = "crowbar"
	icon_state = "crowbar"
	power = 14
	attacktype = "hit"
	attacklog = "hits"

/obj/items/weapon/mop
	name = "mop"
	icon_state = "mop"
	power = 8
	attacktype = "hit"
	attacklog = "hits"

/obj/items/weapon/shard
	name = "shard"
	icon_state = "shard1"
	power = 10
	sharp = 1
	attacktype = "slash"
	attacklog = "cuts"
	New()
		icon_state = "shard[pick("1","2","3")]"