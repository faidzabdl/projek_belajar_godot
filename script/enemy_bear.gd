extends CharacterBody2D

var battle_scene = "res://scene/battle_scene.tscn"
var hp = 100
var maxHp = 100
var nama = "Bear"

@onready var hp_label: Label = $HpLabel

signal hp_changed(new_hp: int)

func _ready():
	Global.maxHpEnemyBear = 100
	Global.hpEnemyBear = 100
	Global.nameEnemyBear = "Bear"	
	$panah.visible = false

func _on_area_2d_body_entered(body) -> void:
	
	Global.enemy = "res://scene/enemy/enemy_bear.tscn"
	Global.player = "res://scene/player.tscn"
	Global.player_on_battle = true
	
	get_tree().change_scene_to_file(battle_scene)
	pass # Replace with function body.
	
func take_damage(amount: int):
	var damage = min(hp, amount)
	hp -= damage
	emit_signal("hp_changed", hp)
	Global.attack = false
	if hp <= 0: hp = 0
	if hp == 0: 
		#modulate = Color.GRAY
		queue_free()



func _on_area_2d_mouse_entered() -> void:
	if Global.attack == true:
		$panah.visible = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	$panah.visible = false
	pass # Replace with function body.


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Global.attack == true:
		if event is InputEventMouseButton and event.is_pressed():
			print("enemy di klik")
			take_damage(50)
			print(hp)
	pass # Replace with function body.
