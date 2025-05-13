extends Area2D



func _on_body_entered(body):
	if body is Player:
		Dialogic.start("scene1")
		get_tree().paused
