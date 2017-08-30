/obj/items/weapon
	var/power = 0
	var/sharp = 0

/obj/items/weapon/screwdriver
	name = "screwdriver"
	icon_state = "screwdriver"
	power = 10
	sharp = 1

/obj/items/weapon/knife
	name = "kitchen knife"
	icon_state = "knife"
	power = 13
	sharp = 1

/obj/items/weapon/pickaxe
	name = "pickaxe"
	icon_state = "pickaxe"
	power = 14
	sharp = 1

/obj/items/weapon/bat
	name = "baseball bat"
	icon_state = "bat"
	power = 15

/obj/items/weapon/bat/lucille
	name = "lucille"
	icon_state = "lucille"
	power = 19

/obj/items/weapon/crowbar
	name = "crowbar"
	icon_state = "crowbar"
	power = 14

/obj/items/weapon/mop
	name = "mop"
	icon_state = "mop"
	power = 8

/obj/items/weapon/shard
	name = "shard"
	icon_state = "shard1"
	power = 10
	sharp = 1
	New()
		icon_state = "shard[pick("1","2","3")]"