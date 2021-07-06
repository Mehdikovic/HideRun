extends Timer

class_name TimerTick

signal tick

export var tick : float = 1

var timer_ticked : Timer


func _ready():
	connect("timeout", self, "_on_timer_timeout")

	timer_ticked = Timer.new()
	add_child(timer_ticked)

	timer_ticked.wait_time = tick
	timer_ticked.one_shot = false
	timer_ticked.autostart = false
	timer_ticked.connect("timeout", self, "_on_timerTicked_timeout", [tick])


# signal of [main timer]
func _on_timer_timeout():
	if one_shot:
		timer_ticked.stop()


# signal of [timerTicker]
func _on_timerTicked_timeout(var tick_time):
	emit_signal("tick", tick_time)


# overrided the start()
func start(time_sec = -1):
	timer_ticked.start()
	.start(time_sec)


#overrided the stop()
func stop():
	.stop()
	timer_ticked.stop()







