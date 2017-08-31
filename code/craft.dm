/mob/living/verb/craft_furniture()
	set name = "Furniture"
	set category = "Craft"
	var/turf/T = src.loc
	var/obj/items/metal/M
	var/pick = input("Что будем создавать?") in list("Пол", "Стена", "Дверь", "Решетка", "Стол") as text|null
	if(pick && !isDead)
		switch(pick)
			if("Пол")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает пол!"
						new/turf/simulated/floor(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог построить!"
						del M
			if("Дверь")
				for(M in T)
					if(prob(craftskill*30)+5)
						view() << "<B>[src.name]</B> создает дверь!"
						new/obj/machinery/doors/cage(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог построить!"
						del M
			if("Стена")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает заготовку дл[ya] стены!"
						new/obj/structures/girder(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог построить!"
						del M
			if("Решетка")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает решетку!"
						new/obj/structures/grille(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог построить!"
						del M
			if("Стол")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает стол!"
						new/obj/structures/table(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог построить!"
						del M

/mob/living/verb/craft_tools()
	set name = "Tools"
	set category = "Craft"
	var/turf/T = src.loc
	var/obj/items/metal/M
	var/pick = input("Инструментики") in list ("Отвертка", "Лом", "Кирка") as text|null
	if(pick && !isDead)
		switch(pick)
			if("Отвертка")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает отвертку!"
						new/obj/items/weapon/screwdriver(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог создать!"
						del M
			if("Лом")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает фомочку!"
						new/obj/items/weapon/crowbar(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог создать!"
						del M
			if("Кирка")
				for(M in T)
					if(prob(craftskill*30))
						view() << "<B>[src.name]</B> создает кирку!"
						new/obj/items/weapon/pickaxe(T)
						del M
					else
						view() << "<B>[src.name]</B> - неудачник, который ничего не смог создать!"
						del M

/mob/living/verb/craft_devices()
	set name = "Devices"
	set category = "Craft"
	var/turf/T = src.loc
	var/obj/items/metal/M
	var/obj/items/battery/B
	var/obj/items/modules/st_cb/ST
	var/pick = input("Девайсы") in list ("Картридж", "Анализер") as text|null
	if(pick && !isDead)
		switch(pick)
			if("Картридж")
				for(M in T)
					for(B in T)
						if(prob(craftskill*30))
							view() << "<B>[src.name]</B> создает картридж!"
							new/obj/items/cartridge(T)
							del(M)
							del(B)
						else
							view() << "<B>[src.name]</B> - неудачник, который ничего не смог создать!"
							del(M)
							del(B)
			if("Анализер")
				for(M in T)
					for(B in T)
						for(ST in T)
							if(prob(craftskill*30))
								view() << "<B>[src.name]</B> создает анализер!"
								new/obj/items/devices/analyzer(T)
								del(M)
								del(B)
								del(ST)
							else
								view() << "<B>[src.name]</B> - неудачник, который ничего не смог создать!"
								del(M)
								del(B)
								del(ST)


