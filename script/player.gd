class_name Player extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	Global.hpPlayer = 100
	Global.maxHpPlayer = 100	
	pass
	
func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#Dialogic.start("scene1")
	velocity = Vector2(0,0)
	#if (  Input.is_action_pressed("ui_right"))	:
		#$KarakterBody.velocity = Vector2(200, 0)
		#pass
	#if (  Input.is_action_pressed("ui_left"))	:
		#$KarakterBody.velocity = Vector2(-200, 0)
		#pass
	#if (  Input.is_action_pressed("ui_up")):
		#$KarakterBody.velocity = Vector2($KarakterBody.velocity.x, -200)
		#pass
	#if (  Input.is_action_pressed("ui_down"))	:
		#$KarakterBody.velocity = Vector2($KarakterBody.velocity.x, 200)
		#pass		
	if !(Global.player_on_battle):
		if ( Input.is_action_pressed("ui_accept")):
			if (  Input.is_action_pressed("ui_up")):
				velocity = Vector2(velocity.x, -200)
				pass
			if (  Input.is_action_pressed("ui_down"))	:
				velocity = Vector2(velocity.x, 200)
				pass	
			if (  Input.is_action_pressed("ui_right"))	:
				velocity = Vector2(200, 0)
				pass
			if (  Input.is_action_pressed("ui_left"))	:
				velocity = Vector2(-200, 0)
				pass
		
		else :
			if (  Input.is_action_pressed("ui_up")):
				velocity = Vector2(velocity.x, -100)
				pass
			if (  Input.is_action_pressed("ui_down"))	:
				velocity = Vector2(velocity.x, 100)
				pass
			if (  Input.is_action_pressed("ui_right"))	:
				velocity = Vector2(100, 0)
				pass
			if (  Input.is_action_pressed("ui_left"))	:
				velocity = Vector2(-100, 0)
				pass
		
		move_and_slide()
	
	if (velocity.x == 0 && velocity.y == 0):
		animation.play("idle")
		pass
	if (velocity.x > 0):
		animation.play("lari_kanan")	
		pass
	if (velocity.x < 0):
		animation.play("lari_kiri")	
		pass
	if (velocity.y > 0):
		animation.play("lari_bawah")	
		pass
	if (velocity.y < 0):
		animation.play("lari_atas")	
		pass			
	pass
