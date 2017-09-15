/obj/items/food
	var/mining = 0
	var/medicine = 0
	var/melee = 0
	var/craft = 0

/obj/items/food/books
	icon = 'items.dmi'

/obj/items/food/books/meinkraft
	name = "Meinkraft"
	icon_state = "meinkraft"
	units = 1
	nutriments = 30
	mining = 1
	craft = 1

/obj/items/food/books/anatomy
	name = "Anatomy"
	icon_state = "anatomy"
	units = 1
	nutriments = 30
	medicine = 1

/obj/items/food/books/law
	name = "Book of Law"
	icon_state = "law"
	units = 1
	nutriments = 30
	melee = 1
