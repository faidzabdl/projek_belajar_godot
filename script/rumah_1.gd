extends Node2D
var player
func _ready():
	if scene_manager.player:
		add_child(scene_manager.player)
		player = scene_manager.player
	else:
		print("tidak ada") 
			
