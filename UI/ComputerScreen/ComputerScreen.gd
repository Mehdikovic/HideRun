extends Popup


onready var dispaly : RichTextLabel = $NinePatchRect/Display

func show_popup(combination):
	update_display(PoolStringArray(combination).join(""))
	popup_centered()


func update_display(combination):
	dispaly.bbcode_text = "The combination is " + combination + " don't forget it. This is the last time i show it to you."