extends Area2D

signal combination_generated

export var length : int = 4
export var group_label = "1"

var is_player_in_area = false
var combination

onready var light : Light2D = $Light2D
onready var popup : Popup = $UI/ComputerScreen
onready var textLabel : Label = $TextLabel


func _ready():
	light.enabled = false
	combination = CombinationGenerator.generate(length)
	textLabel.text = group_label
	emit_signal("combination_generated", combination, group_label)


func _input(event):
	if is_player_in_area and Input.is_action_just_pressed("interact"):
		handle_computer()


func _on_CombinationComputer_body_entered(body):
	is_player_in_area = true


func _on_CombinationComputer_body_exited(body):
	is_player_in_area = false
	light.enabled = false
	popup.hide()


func handle_computer():
	light.enabled = true
	popup.show_popup(combination)











