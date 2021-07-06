extends Node2D

onready var ObjectivePointer = $ObjectivePointer
onready var ObjectiveMarkers = $ObjectiveMarkers

var messages

func _ready():
	messages = read_json_message_file()
	select_objective(0)


func select_objective(number : int):
	$HUD/MessageDisplay/NinePatchRect/Label.text = messages[str(number)]
	var marker = ObjectiveMarkers.get_child(number)
	ObjectivePointer.position = marker.position


func _on_MoveArea_body_entered(body):
	select_objective(1)


func _on_DoorArea_body_entered(body):
	select_objective(2)


func _on_NightVisionArea_body_entered(body):
	select_objective(3)


func _on_BriefcaseArea_body_entered(body):
	select_objective(4)


func read_json_message_file():
	var file = File.new()
	file.open(Global.MESSAGE_FILE_JSON, File.READ)
	var content = file.get_as_text()
	file.close()
	return parse_json(content)








