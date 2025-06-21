extends BasedScene
@onready var bear: Marker2D = $markerSetelahFight/Bear
@onready var bat: Marker2D = $markerSetelahFight/Bat
@onready var bgm: AudioStreamPlayer = $AudioStreamPlayer
@onready var Uimenu: Control = $UI
@onready var camera_2d_2: Camera2D = $Camera2D2


#@onready var player: Player = $Player
@onready var camera = $Camera2D
func _ready():
	bgm.play()
	Uimenu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	#if Global.posisiTerakhir:
		#player.global_position = Global.posisiTerakhir
		#Global.posisiTerakhir = null

	if bat.name == Global.posisiSetelahFight:
		player.global_position = bat.global_position
		Global.posisiSetelahFight = null
	elif bear.name == Global.posisiSetelahFight:
		player.global_position = bear.global_position
		Global.posisiSetelahFight = null	
		
	super()
	if player == null:
		print("can nyampe")
		return
	camera.player = player	

func _process(delta: float) -> void:
	print(player.name)
	pass


func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_cancel") ):
		#Global.posisiTerakhir = self.global_position
		#get_tree().change_scene_to_file("res://scene/UI/ui.tscn")
		Uimenu.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		camera_2d_2.make_current()	
		
	pass
