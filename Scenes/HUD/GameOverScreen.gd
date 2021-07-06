extends CanvasLayer


func _on_Retry_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1/Level1.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_ReturnToMain_pressed():
	get_tree().change_scene("res://Scenes/HUD/Main.tscn")
