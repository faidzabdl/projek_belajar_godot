extends CharacterBody2D

@export var speed: float
@export var move_distance: float

@onready var player_ui: AnimatedSprite2D = $AnimatedSprite2D

var direction: int = 1
var start_position: Vector2
var is_moving = true

func _ready():
	start_position = global_position

func _physics_process(delta):
	# Atur velocity dulu
	if is_moving:
		velocity.x = speed * direction
	else:
		velocity = Vector2.ZERO
	
	# Cek benturan sebelum gerak
	if is_on_wall():
		is_moving = false
		velocity = Vector2.ZERO
		player_ui.stop()
	else:
		is_moving = true

	# Gerakkan sekali saja
	#move_and_collide(velocity * delta)
	move_and_slide()

	# Atur animasi sesuai gerakan
	if is_moving:
		if direction == 1:
			player_ui.play("jalan_kanan")
		else:
			player_ui.play("jalan_kiri")
	
	# Balik arah kalau sudah melewati jarak tertentu
	if is_moving and abs(global_position.x - start_position.x) > move_distance:
		direction *= -1
