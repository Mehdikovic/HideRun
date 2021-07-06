extends Popup

signal guess_correct

# LockedDoor will pass its value
var combination : Array
var guess : Array = []

onready var display : RichTextLabel = $VSplitContainer/DisplayContainer/Display
onready var status : TextureRect = $VSplitContainer/ButtonContainer/GridContainer/Status
onready var audioPlayer : AudioStreamPlayer = $AudioStreamPlayer
onready var correctGuessTimer : Timer = $CorrectGuessTimer
onready var checkTimer : Timer = $CheckTimer


func _ready():
	reset_lock()


func show_popup():
	assert(combination.size() != 0) # check if _on_computer_combination_generated of Parent signal is connected or not
	call_deferred("popup_centered")


func _on_button_pressed(button_text):
	if button_text != "OK":
		enter(int(button_text))

	if button_text == "OK" or guess.size() == combination.size():
		get_tree().call_group("popup_buttons", "disable")
		checkTimer.start()


func check_combination_guess():
	if combination == guess: # check every item in the array not the references
		sfx_play("res://Assets/SFX/threeTone1.ogg")
		status.texture = load(Global.GREEN_LIGHT)
		get_tree().call_group("popup_buttons", "disable")
		correctGuessTimer.start()
	else:
		reset_lock()


func enter(number : int):
	guess.append(number)
	update_display()
	sfx_play("res://Assets/SFX/twoTone1.ogg")


func reset_lock():
	guess.clear()
	display.clear()
	status.texture = load(Global.RED_LIGHT)
	get_tree().call_group("popup_buttons", "enable")


func update_display():
	display.bbcode_text = "[center]" + PoolStringArray(guess).join("") + "[/center]"


func _on_CorrectGuessTimer_timeout():
	emit_signal("guess_correct")
	hide()
	$CorrectGuessLabel.text = PoolStringArray(guess).join("")
	reset_lock()


func _on_CheckTimer_timeout():
	check_combination_guess()


func sfx_play(path : String):
	audioPlayer.stream = load(path)
	audioPlayer.play()




