extends "res://Scenes/Character/Character.gd"

export var FOV = 44
export var view_range = 330
export var RED : Color = Color(1.0, 0.25, 0.25)
export var DEFAULT_COLOR : Color

onready var player = Global.player
onready var flashlight : Light2D = $Flashlight

func _ready():
	add_to_group("NPC")
	DEFAULT_COLOR = flashlight.color

func _process(delta):
	if check_player_detection():
		flashlight.color = RED
		get_tree().call_group("SuspicionMeter", "seen")
	else:
		flashlight.color = DEFAULT_COLOR


func check_player_detection() -> bool:
	return player_is_in_FOV() and player_is_in_range() and player_is_in_LOS()


func player_is_in_FOV() -> bool:
	var direction : Vector2 = Vector2(1, 0).rotated(global_rotation)
	var player_to_detector : Vector2 = (player.global_position - global_position)
	return abs(player_to_detector.angle_to(direction)) < deg2rad((FOV / 2))


func player_is_in_range() -> bool:
	return (player.global_position - global_position).length_squared() < pow(view_range, 2)


func player_is_in_LOS() -> bool:
	var space : Physics2DDirectSpaceState = get_world_2d().direct_space_state
	var result = space.intersect_ray(global_position, player.global_position, [self], collision_mask)
	if not result:
		return false
	return result.collider == player


func turn_off_flashlight():
	flashlight.enabled = false


func turn_on_flashlight():
	flashlight.enabled = true




