extends TextureProgress

export var suspicion_step : float = 50
export var suspicion_decrease : float = 10

var suspicion : float = 0

func _ready():
	add_to_group("SuspicionMeter")


func _process(delta):
	suspicion -= (suspicion_decrease * delta)
	suspicion = clamp(suspicion, min_value, max_value)
	value = suspicion


func seen():
	suspicion += (suspicion_step * get_process_delta_time())
	if suspicion >= 100:
		end_game()


func end_game():
	get_tree().change_scene("res://Scenes/HUD/GameOverScreen.tscn")