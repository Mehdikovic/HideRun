extends Area2D

var is_door_open = false
var is_player_in_area = false

onready var anim : AnimationPlayer = $AnimationPlayer



func _input(event):
	if is_player_in_area and Input.is_action_just_pressed("interact"):
		handle_door_state()


func _on_Door_body_entered(body : PhysicsBody2D):
	if body.get_groups().has("Guard"):
		open_door()
	if body == Global.player:
		is_player_in_area = true


func _on_Door_body_exited(body : PhysicsBody2D):
	if body == Global.player:
		is_player_in_area = false


func open_door():
	if is_door_open or $AnimationPlayer.is_playing():
		return
	anim.play("open")
	is_door_open = true


func close_door():
	if not is_door_open or $AnimationPlayer.is_playing():
		return
	anim.play("close")
	is_door_open = false


func handle_door_state():
	if is_door_open:
		close_door()
	else:
		open_door()

