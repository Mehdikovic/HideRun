extends Node2D



func _on_Tutorial_pressed():
	get_tree().change_scene("res://Scenes/Levels/Tutorial/Tutorial.tscn")


func _on_Game_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1/Level1.tscn")


func _on_Exit_pressed():
	get_tree().quit()
