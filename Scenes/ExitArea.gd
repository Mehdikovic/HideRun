extends Area2D


# body has to be player because area mask is configured to respond to just player
func _on_ExitArea_body_entered(body):
	if body.has_briefcase():
		get_tree().change_scene("res://Scenes/HUD/VictoryScreen.tscn")
