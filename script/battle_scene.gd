extends Node2D

var player
var enemyName
var hpEnemyBat
var hpPlayer
@onready var label: Label = $CanvasLayer/Label
@onready var attackButton: Button = $CanvasLayer/MenuAttack/VBoxContainer/Attack

@onready var enemy_container: VBoxContainer = $CanvasLayer/StatusEnemy/VBoxContainer
@onready var button_container: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var audio_stream_bgm: AudioStreamPlayer = $AudioStreamPlayer
@onready var succes: AudioStreamPlayer = $succes
@onready var death: AudioStreamPlayer = $death


var Turn = [
	0,
]

var giliran
var enemies = []
var labels = []
var enemy_data
var enemyHidup = []

var load_scene_e = load(Global.enemy)

func _ready() -> void:
	
	await get_tree().create_timer(1.0).timeout
	audio_stream_bgm.play()
	giliran = 1	
	enemyName = $CanvasLayer/StatusEnemy/VBoxContainer/nama
	hpEnemyBat = $CanvasLayer/StatusEnemy/VBoxContainer/Hp
	#randomize()
	#_spawn_enemies(randi_range(1, 3))
	#update_ui()
	hpPlayer = $CanvasLayer/MenuAttack/hpPlayer
	#
	spawn()
	enemy_alive()
	print(labels[0])
	
	
	#if giliran != 1:
		#enemy_attack()
	
	
	
	
		

#batas ready yee ehehehe

#func _process(delta):
	#print("enemy: %d " % [enemies.size()])
	#print("Turn: %d" % [Turn.size()])
	#print("giliran " + str(giliran) )
	#print(labels.size())
	#print("banyak nya player dan musuh " + str(Turn.size()) )	
	

		
func enemy_alive():
	enemyHidup.clear()
	for i in enemies:
		if i.hp > 0:
			enemyHidup.append(i)
		


func spawn():
	if Global.player && Global.enemy:
		var load_scene_p = load(Global.player)
		var init_scene_p = load_scene_p.instantiate()
		init_scene_p.scale = Vector2(8,8)
		player = init_scene_p
		$area_player.add_child(init_scene_p)
		hpPlayer.text = "HP : " + str(Global.hpPlayer)
	
	for i in range(randi_range(1,3)):
			var init_scene_e = load_scene_e.instantiate()
			Global.posisiSetelahFight = init_scene_e.nama
			print(Global.posisiSetelahFight)
			init_scene_e.position = Vector2(50 + i * 150, 20)
			init_scene_e.scale = Vector2(8,8)
			$area_enemy.add_child(init_scene_e)
			enemies.append(init_scene_e)
			Turn.append(i + 1)
			
			#init_scene_e.connect("hp_changed", self, "_on_enemy_hp_changed", [i])
			init_scene_e.hp_changed.connect(_on_enemy_hp_changed.bind(init_scene_e))
			
			var label = Label.new()
			label.text = "%s - HP: %d" % [init_scene_e.nama, init_scene_e.hp]
			$CanvasLayer/StatusEnemy/VBoxContainer.add_child(label)
			labels.append(label)
				
func _on_enemy_hp_changed(new_hp: int, enemy_node) -> void:
	if not is_instance_valid(enemy_node):
		return
	var index = enemies.find(enemy_node)
	if index == -1:
		return
	
	labels[index].text = "%s - HP: %d " % [enemy_node.nama, new_hp]
	enemy_alive()
	await enemyDied()
	await checkWin()	
	nextTurn()							

func _on_attack_pressed() -> void:
	if giliran == 1:
		Global.attack = true
		label.text = "SILAHKAN PILIH ENEMY"
	pass # Replace with function body.

func enemy_attack():
	await get_tree().create_timer(3.0).timeout
	var serangan = min(Global.hpPlayer, 10)
	Global.hpPlayer -= serangan
	hpPlayer.text = "HP : " + str(Global.hpPlayer)
	player.modulate = Color.RED
	await get_tree().create_timer(2.0).timeout
	player.modulate = Color(1,1,1)
	enemies[giliran - 2].modulate = Color.AZURE
	#await get_tree().create_timer(1.0).timeout
	await checkWin()
	nextTurn()	
	
func nextTurn():
	giliran = giliran + 1
	if giliran > Turn.size():
		giliran = 1
	if giliran != 1:
		label.text = "musuh menyerang!!!"
		enemies[giliran - 2].modulate = Color(1.5, 1.5, 1.5)
		print(giliran - 2)
		enemy_attack()
	else:
		label.text = "GILIRAN anda"		

func checkWin():
	if Global.hpPlayer == 0:
		label.text = "ANDA KALAH"
		audio_stream_bgm.stop()
		death.play()
		await get_tree().create_timer(3.0).timeout
		Global.player_on_battle = false
		get_tree().change_scene_to_file("res://scene/main_node.tscn")
	elif enemyHidup.size() == 0:
		label.text = "selamat ANDA MENANG !!!"
		audio_stream_bgm.stop()
		succes.play()
		await get_tree().create_timer(3.0).timeout
		Global.player_on_battle = false
		get_tree().change_scene_to_file("res://scene/main_node.tscn")
								
func enemyDied():
	var to_remove = []
	var label_remove
	for i in range(enemies.size()):
		if enemies[i].hp <= 0:
			to_remove.append(i)
			#label_remove = i
	to_remove.reverse()
	for i in to_remove:
		var enemy = enemies[i]
		if is_instance_valid(enemy):
			enemy.call_deferred("queue_free")
			#labels[label_remove].queue_free()
			#print(labels[label_remove])
			var label = labels[i]
			if is_instance_valid(label):
				label.queue_free()
			labels.remove_at(i)	
			#labels.erase(labels[label_remove])
			enemies.remove_at(i)
			Turn.remove_at(Turn.size() - 1)		
