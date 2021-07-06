extends "res://Scenes/Character/Character.gd"
enum VisionMode { DARK, NIGHT_VISION }

var motion : Vector2 = Vector2()
var Flashlight : Light2D = null
var vision_mode # Will Fill with VisionMode above in _ready func
var can_change_vision_mode = true # Controller for vision mode change
var disguised = false # Controller for disguise mode change

export var disguises : int = 3 # How many disguises our player has
export var disguise_time_out : float = 5 # How long a disguise action may take
export var disguise_speed_friction : float = 0.10 # How much friction player has in the disguise mode (0, 1]

var speed_multiplier : float = 1 # In disguised mode we have to slow our player

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
onready var light_occluder = $LightOccluder2D
onready var light = $Light2D
onready var vision_mode_timer = $VisionModeTimer
onready var disguise_timer = $DisguiseTimer
onready var gui_progressBar : ProgressBar = $GUI/DisguiseProgressBar


func _ready():
	vision_mode = VisionMode.DARK
	Global.player = self
	Flashlight = $Flashlight
	Flashlight.visible = false
	disguise_timer.wait_time = disguise_time_out
	reveal()
	update_box_item_list(disguises)


func _process(delta):
	$GUI.global_rotation = 0
	gui_progressBar.value = disguise_timer.time_left * 100 / disguise_time_out


func _physics_process(delta):
	update_motion()
	rotate_to_mouse()
	#fast_motion_action()
	move_and_slide(motion * speed_multiplier)


func _input(event):
	if Flashlight and Input.is_action_just_pressed("flashlight"):
		toggle_flashlight()
	if can_change_vision_mode and Input.is_action_just_pressed("night_vision_change"):
		can_change_vision_mode = false
		vision_mode_timer.start()
		change_vision_mode()
	if Input.is_action_just_pressed("disguise"):
		toggle_disguise()


# USER DEFINED METHODS
func update_motion():
	motion = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
	if Input.is_action_pressed("ui_down"):
		motion.y += 1

	if motion.length_squared() > 0:
		motion = motion.normalized()
		motion *= SPEED


func fast_motion_action():
	if not Input.is_action_just_pressed("fast_motion"):
		return
	if Input.is_action_pressed("ui_left"):
		motion.x -= 10000
	if Input.is_action_pressed("ui_right"):
		motion.x += 10000
	if Input.is_action_pressed("ui_up"):
		motion.y -= 10000
	if Input.is_action_pressed("ui_down"):
		motion.y += 10000


func rotate_to_mouse():
	look_at(get_global_mouse_position())


func toggle_flashlight():
	Flashlight.visible = not Flashlight.visible


func change_vision_mode():
	if vision_mode == VisionMode.DARK:
		vision_mode = VisionMode.NIGHT_VISION
		get_tree().call_group("interface", "NightVision_mode")
	elif vision_mode == VisionMode.NIGHT_VISION:
		vision_mode = VisionMode.DARK
		get_tree().call_group("interface", "Dark_mode")


func _on_VisionModeTimer_timeout():
	can_change_vision_mode = true


func toggle_disguise():
	if disguised:
		reveal()
		disguise_timer.stop()
	elif disguises > 0:
		disguises -= 1
		update_box_item_list(disguises)
		disguise()
		disguise_timer.start()


func reveal():
	disguised = false
	gui_progressBar.hide()
	sprite.texture = load(Global.player_PLAYER_SPRITE)
	collision_shape.shape = load(Global.player_PLAYER_COLLISION_SHAPE)
	light_occluder.occluder = load(Global.player_PLAYER_OCCLUDER)
	light.texture = load(Global.player_PLAYER_LIGHT)

	speed_multiplier = 1

	collision_layer = 1


func disguise():
	disguised = true
	gui_progressBar.show()
	sprite.texture = load(Global.player_BOX_SPRITE)
	collision_shape.shape = load(Global.player_BOX_COLLISION_SHAPE)
	light_occluder.occluder = load(Global.player_BOX_OCCLUDER)
	light.texture = load(Global.player_BOX_LIGHT)

	speed_multiplier = disguise_speed_friction

	collision_layer = 2


func update_box_item_list(number):
	get_tree().call_group("ItemList", "make_item_lists", number)


func collect_item(collected_item):
	add_child(collected_item)
	get_tree().call_group("interface", "collect_loot")


func has_briefcase():
	return has_node("Briefcase")



