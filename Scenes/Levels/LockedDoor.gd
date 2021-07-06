extends "res://Scenes/Levels/Door.gd"

var combination

onready var numberPad : Popup = $UI/NumberPad
onready var connectedComputerLabel : Label = $ConnectedComputerLabel

export var password_for_ever : bool = false
var is_door_locked : bool = true

# overrided - Called in _input() Callback
func handle_door_state():
	if is_door_open:
		close_door()
	elif is_door_locked or password_for_ever:
		numberPad.show_popup()
	else:
		open_door()


# overrided - Area2D body exit signal
func _on_Door_body_exited(body : PhysicsBody2D):
	if body == Global.player:
		is_player_in_area = false
		numberPad.hide()


# overrided - close_door() method
func close_door():
	.close_door()
	if password_for_ever:
		$PlayerStopObstacle/CollisionShape2D.disabled = false


# signal emitted by popup
func _on_numberPad_guess_correct():
	$PlayerStopObstacle/CollisionShape2D.disabled = true
	is_door_locked = false
	open_door()


# signal emitted by CombinationComputers
func _on_computer_combination_generated(combination, connected_computer_text):
	numberPad.combination = combination
	connectedComputerLabel.text = connected_computer_text





