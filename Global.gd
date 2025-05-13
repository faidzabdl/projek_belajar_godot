extends Node

var enemy
var enemy_count = randi_range(1, 3)
var player
var player_on_battle = false

#status player
var hpPlayer
var maxHpPlayer
var posisiSetelahFight

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


var shake_node
var magnitudo: float = 10.0

var is_shaking : bool = false
var shake_amt : Vector2 = Vector2.ZERO

func shake():
	if !is_shaking: return
	
	shake_amt = Vector2(randf_range(-1,1), randf_range(-1,1) ) * magnitudo 
	 
