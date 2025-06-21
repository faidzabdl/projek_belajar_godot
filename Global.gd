extends Node
var item = {}

var enemy
var enemy_count = randi_range(1, 3)
var player
var player_on_battle = false

#status player
var hpPlayer
var maxHpPlayer
var posisiSetelahFight
var playerD = {
	"nama" = "edward",
	"hp" = 100,
	"mp" = 100,
	"gold" = 100,
	"iconPlayer"= "res://assets/images/character/Faceset.png"
}
var posisiTerakhir


#status enemy_bat
var hpEnemyBat
var maxHpEnemyBat
var nameEnemyBat

#status enemy_bear
var hpEnemyBear
var maxHpEnemyBear
var nameEnemyBear

#kebutuhan battle
var attack = false



#shake saat diserang
var target_node
var original_pos = Vector2.ZERO
var shake_time = 0.0
var shake_duration = 0.0
var shake_intensity = 5.0

func _process(delta):
	#if item:
		#for item_key in item.keys():
			#var item_data = item[item_key]
			#print("nama: ", item_data.name, "Qty: ", item_data.qty)
	#else:
		#print("tidak ada item")		  
	
	if target_node != null:
		shake_time -= delta
		if shake_time > 0:
			target_node.position = original_pos + Vector2(
				randf_range(-shake_intensity, shake_intensity),
				randf_range(-shake_intensity, shake_intensity)
			)
		else:
			target_node.position = original_pos	
			target_node = null
			
func shake(node: Node2D, duration = 0.2, intensity = 5.0):
	target_node = node
	original_pos = node.position
	shake_duration = duration
	shake_time = duration
	shake_intensity = intensity
				


#item


func setItem(name: String, qty: int, icon: String):
	if item.has(name):
		item[name]["qty"] += qty
	else:	
		item[name] = {"name": name, "qty": qty, "icon": icon}
	pass
