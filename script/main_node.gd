extends BasedScene
@onready var bear: Marker2D = $markerSetelahFight/Bear
@onready var bat: Marker2D = $markerSetelahFight/Bat

#@onready var player: Player = $Player
@onready var camera = $Camera2D
func _ready():
	
	if bat.name == Global.posisiSetelahFight:
		player.global_position = bat.global_position
	elif bear.name == Global.posisiSetelahFight:
		player.global_position = bear.global_position	
		
	
	super()
	camera.player = player	
