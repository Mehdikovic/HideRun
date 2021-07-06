extends CanvasModulate

export var DARK : Color = Color("090042")
const NIGHT_VISION : Color = Color("00d02f")

onready var sound_player = $Sound


func _ready():
	add_to_group("interface")
	get_tree().call_group("Labels", "hide")
	color = DARK


func NightVision_mode():
	color = NIGHT_VISION
	get_tree().call_group("NPC", "turn_off_flashlight")
	get_tree().call_group("Labels", "show")
	sound_player.stream = load(Global.sfx_NIGHT_VISION_ON)
	play_sfx()


func Dark_mode():
	color = DARK
	get_tree().call_group("NPC", "turn_on_flashlight")
	get_tree().call_group("Labels", "hide")
	sound_player.stream = load(Global.sfx_NIGHT_VISION_OFF)
	play_sfx()


func play_sfx():
	sound_player.play()








