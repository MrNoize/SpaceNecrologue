/obj/landmarks/lootspawner
    icon = 'effects.dmi'
    icon_state = "loot"
    New()
        spawnitem()

    proc/spawnitem()
        var/I = pick(/obj/items/cartridge, /obj/items/weapon/pipe, /obj/items/weapon/screwdriver, /obj/items/drugs/bandage, /obj/items/drugs/ointment, /obj/items/food/borscht, /obj/items/food/crisps, /obj/items/weapon/knife)
        new I(src.loc)
        del src

var/global/maxzombies = 45

/obj/landmarks/zombiespawner
	icon = 'effects.dmi'
	icon_state = "zombie"
	New()
		..()
		icon = null
		spawnzombie()

	proc/spawnzombie()
		if(zombies < maxzombies)
			var/Z = /mob/living/zombie
			new Z(src.loc)
			spawn(600)	spawnzombie()
