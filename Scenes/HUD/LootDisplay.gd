extends NinePatchRect

func _ready():
	visible = false
	add_to_group("interface")


func collect_loot():
	visible = true
	$VBoxContainer/ItemList.add_icon_item(Global.BRIEFCASE_ITEM_ICON, false)