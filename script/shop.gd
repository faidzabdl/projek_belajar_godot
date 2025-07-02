extends Node2D

@onready var item: NinePatchRect = $item
@onready var player: Player = $Player
#@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var qtyDibeli: SpinBox = $item/SpinBox
@onready var gold: Label = $item/gold
#var hp
var effect
var hargaJual
var itemDibeli
var iconDibeli
var goldPlayer = Global.playerD["gold"]
#func _ready() -> void:
	#item.visible = false
	
	
func _ready():
	gold.text = str(goldPlayer)
	item.visible = false
	qtyDibeli.visible = false
	
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)	
		
		call_deferred("position_player")

func _process(delta: float) -> void:
	pass		
	
		
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

func _on_area_shop_body_entered(body) -> void:
	if (body == player):
		item.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.			
		 	


func _on_area_shop_body_exited(body: Node2D) -> void:
	if (body == player):
		item.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.

func _on_beli_pressed() -> void:
	if qtyDibeli.value == 0:
		print("belum di set")
		return
	if itemDibeli == null:
		return	
	goldPlayer -= (hargaJual * qtyDibeli.value)
	gold.text = str(goldPlayer)
	Global.playerD["gold"] = goldPlayer	
	Global.setItem(itemDibeli, qtyDibeli.value, iconDibeli, effect)
	print("berhasil di masukkan")
	hargaJual = null
	itemDibeli = null
	qtyDibeli.reset_size()
	qtyDibeli.value = 0
	qtyDibeli.visible = false
	iconDibeli = null
	pass # Replace with function body.

func _on_potion_pressed() -> void:
	qtyDibeli.visible = true
	hargaJual = 5
	itemDibeli = "potion"
	iconDibeli = "res://assets/images/ui/Potion/Medipack.png"
	effect = func():
		Global.playerD["hp"] += 10
	pass # Replace with function body.


func _on_milk_pressed() -> void:
	qtyDibeli.visible = true
	hargaJual = 2
	itemDibeli = "milk"
	iconDibeli = "res://assets/images/ui/Potion/MilkPot.png"
	effect = func():
		Global.playerD["hp"] += 5
	pass # Replace with function body.
	
