class_name BasedScene extends Node

@onready var player: Player = $Player
#@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var entrance_markers: Node2D = $EntranceMarkers


func _ready():
	if Global.posisiTerakhir:
		player.global_position = Global.posisiTerakhir
		Global.posisiTerakhir = null
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)	
		player.name = "Player"
		
		call_deferred("position_player")
	
		
func position_player() -> void:
	var last_scene = scene_manager.last_scene_name
	#print(last_scene)
	if last_scene.is_empty():
		last_scene = "any"
	
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == last_scene:
			player.global_position = entrance.global_position
		#elif entrance is Marker2D and entrance.name == "any2" or entrance.name == last_scene:
			#player.global_position = entrance.global_position	
		 	
			
			
