extends Camera2D

const SCREEN_SIZE := Vector2(320, 180)
var cur_screen := Vector2(0,0)
@onready var player: Player = preload("res://scene/player.tscn").instantiate()
@export var follow_node: Node2D

func _ready():
	set_as_top_level(true)
	
	if player == null:
		print("Player belum ada di scene")
		return
	
	global_position = player.global_position
	_update_screen(cur_screen)
	pass # Replace with function body.

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var parrent_screen : Vector2 = ( player.global_position / SCREEN_SIZE).floor()
	if not parrent_screen.is_equal_approx(cur_screen):
		_update_screen(parrent_screen)		
	pass
	
func _update_screen(new_screen :Vector2):
	cur_screen = new_screen
	global_position = cur_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
