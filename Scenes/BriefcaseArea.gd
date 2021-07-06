extends Area2D


# body has to be player because area mask is configured to respond to just player
func _on_BriefcaseArea_body_entered(body):
	var briefcase_item = Node.new()
	briefcase_item.name = "Briefcase"
	body.collect_item(briefcase_item)
	get_parent().queue_free()
