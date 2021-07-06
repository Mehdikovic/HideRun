extends "res://Scenes/Character/NPCs/PlayerDetection.gd"

var motion : Vector2 = Vector2()
var destination_collection : Array = []
var path : Array = []
var destination : Vector2 = Vector2()

export var speed_factor = 0.5
export var agent_stop_radius = 5

onready var nav : Navigation2D = Global.navigation
onready var destinations : Node2D = Global.destinations

onready var move_timer = $MoveTimer


func _ready():
	add_to_group("Guard")
	destination_collection = destinations.get_children()
	make_path()



func _physics_process(delta):
	navigate()


func navigate():
	var squared_distance_to_destination : float = (global_position - path[0]).length_squared()
	destination = path[0]

	if squared_distance_to_destination > pow(agent_stop_radius, 2):
		move()
	else:
		update_path()


func make_path():
	randomize()
	move_timer.wait_time = randi() % 10 + 5
	var next_destination : Position2D = destination_collection[randi() % destination_collection.size()]
	path = nav.get_simple_path(global_position, next_destination.global_position, false)
	# TODO: DELETE THESE LINES
	print("***** " + name + " ******" + " timeout = " + str(move_timer.wait_time))
	print("selected \"" + next_destination.name + "\" and has these " + str(path))


func move():
	var angle_to_destination = get_angle_to(destination)
	motion = (destination - global_position).normalized() * (MAX_SPEED * speed_factor)

	#SMOOTH ROTATION
	if abs(angle_to_destination) > deg2rad(10):
		global_rotation = lerp(global_rotation, global_rotation + angle_to_destination, get_physics_process_delta_time() * 2)
	else:
		look_at(destination)

	if is_on_wall():
		make_path()

	move_and_slide(motion)


func update_path():
	if path.size() == 1:
		if move_timer.is_stopped():
			move_timer.start()
	else:
		path.remove(0)


func _on_MoveTimer_timeout():
	make_path()




