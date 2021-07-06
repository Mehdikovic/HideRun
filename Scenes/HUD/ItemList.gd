extends ItemList


func make_item_lists(number : int):
	clear()
	number = clamp(number, 0, 7)
	for index in range(number):
		add_icon_item(Global.BOX_ITEM_ICON, false)