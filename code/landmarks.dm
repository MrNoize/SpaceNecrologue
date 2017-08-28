/obj/landmarks/lootspawner
    name = "loot spawner"
    icon = 'effects.dmi'
    icon_state = "loot"

    New()
        spawnitem()
        del(src)

    proc/spawnitem()
        var/I = pick(/obj/items/cartridge, /obj/items/weapon/screwdriver, /obj/items/drugs/bandage, /obj/items/drugs/ointment, /obj/items/food/borscht, /obj/items/food/crisps, /obj/items/weapon/knife)
        new I(src.loc)