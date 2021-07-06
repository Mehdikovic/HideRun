extends Button

onready var parent = $"../../../../"

func _ready():
	add_to_group("popup_buttons")
	connect("pressed", parent, "_on_button_pressed", [text])


func disable():
	disabled = true


func enable():
	disabled = false