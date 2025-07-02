extends Control

@onready var nama: Label = $Player/VBoxContainer/nama
@onready var hp: Label = $Player/VBoxContainer/hp
@onready var mp: Label = $Player/VBoxContainer/mp
@onready var iconPlayer: TextureRect = $Player/TextureRect
@onready var player: NinePatchRect = $Player
@onready var menu: NinePatchRect = $Menu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera2D = $"../Camera2D"
#@onready var item: HBoxContainer = $Inventory/VBoxContainer/item
@onready var items: VBoxContainer = $Inventory/VBoxContainer
@onready var gold: Label = $Player/VBoxContainer/gold


var itemButtonScene = preload("res://scene/UI/item.tscn")
var icon = TextureRect.new()
var itemButton = itemButtonScene.instantiate()
var qty = Label.new()
var item = HBoxContainer.new()
var perubahan = false

var giliran

var itemHabis = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	giliran = 0
	
	#player.global_position = Vector2(-411, 201)
	nama.text = "NAME : %s" % Global.playerD["nama"]
	hp.text = "HP : %s" % Global.playerD["hp"]
	mp.text = "MP : %s" % Global.playerD["mp"]
	gold.text = "GOLD : %s" % Global.playerD["gold"]
	iconPlayer.texture = load(Global.playerD["iconPlayer"])
	
	player.global_position = Vector2(-391,195.5)
	#player.visible = falsegilran
	
	
	#inventory
	spawnItem()
	

		
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_cancel") ):
		if giliran == 1:
			animation_player.play("geser_atas_inven")
			await get_tree().create_timer(0.6).timeout
			animation_player.play("geser_kiri")
			await get_tree().create_timer(0.6).timeout
		elif giliran == 2:
			animation_player.play("geser_kiri_player")
			await get_tree().create_timer(0.6).timeout
			animation_player.play("geser_kiri")
			await get_tree().create_timer(0.6).timeout	
	#if(Input.is_action_just_pressed("ui_accept")):
		#animation_player.play("geser_kanan_player")
	pass

func _on_player_pressed() -> void:
	giliran = 2
	if giliran == 2:
		animation_player.play("geser kanan")
		await get_tree().create_timer(0.6).timeout
	
		animation_player.play("geser_kanan_player")
		await get_tree().create_timer(0.6).timeout
	
	pass # Replace with function body.





func _on_inventory_pressed() -> void:
	giliran = 1
	animation_player.play("geser kanan")
	await get_tree().create_timer(0.6).timeout
	
	animation_player.play("geser_bawah_inven")
	await get_tree().create_timer(0.6).timeout
	pass # Replace with function body.
	
func _on_quit_pressed() -> void:
	#get_tree().change_scene_to_file("res://scene/main_node.tscn")
	giliran = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.visible = false
	camera.make_current()
	
	pass # Replace with function body
	
func spawnItem():
	
	if Global.item:
		for item_key in Global.item.keys():
			var data_item = Global.item[item_key]
			
			
			items.add_child(item)
			item.add_theme_constant_override("separation", 12)
			
			icon.texture = load(data_item["icon"])
			icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			icon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			
			#name.text = data_item["name"]
			#name.theme = preload("res://scene/UI/label_item.tres")
			itemButton.item_name = item_key
			itemButton.qty = Global.item[item_key]["qty"]
			itemButton.connect("change", Callable(self ,"update_player"))
			itemButton.connect("habis", Callable(self, "cekItem"))
			
			qty.text = str(itemButton.qty)
			qty.theme = preload("res://scene/UI/label_item.tres")
			
			item.add_child(icon)
			item.add_child(itemButton)
			item.add_child(qty)
			
			
		
			
	else:
		print("tidak ada item")	

func update_player():
	hp.text = "HP : %s" % Global.playerD["hp"]
	
func cekItem():	
	icon.queue_free()
	qty.queue_free()
	
