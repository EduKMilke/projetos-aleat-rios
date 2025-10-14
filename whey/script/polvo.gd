extends CharacterBody2D



const ACCELERATION = 400.0 
const ARRIVAL_DISTANCE = 20.0 
const mrg = 100.0
const spd_m2=80
var spd_m = spd_m2
var l_tela = 0.0
var al_tela = 0.0
var alvo = Vector2.ZERO 
@onready var spr=$AnimatedSprite2D

func _ready() -> void:
	randomize()
	spr.play("default")
	l_tela = get_viewport_rect().size.x
	al_tela = get_viewport_rect().size.y
	
	var spawn_side = randi() % 4

	match spawn_side:
		0:
			position.x = -mrg
			position.y = randf_range(0, al_tela)
			alvo.x = l_tela + mrg
			alvo.y = randf_range(0, al_tela)
			
		1: 

			position.x = l_tela + mrg
			position.y = randf_range(0, al_tela)
			

			alvo.x = -mrg
			alvo.y = randf_range(0, al_tela)
			
		2: 
			position.x = randf_range(0, l_tela)
			position.y = -mrg
			

			alvo.x = randf_range(0, l_tela)
			alvo.y = al_tela + mrg
			
		3: 
			position.x = randf_range(0, l_tela)
			position.y = al_tela + mrg
			alvo.x = randf_range(0, l_tela)
			alvo.y = -mrg

	look_at(alvo)

func _physics_process(delta: float) -> void:
	var distance = position.distance_to(alvo)
	if distance > ARRIVAL_DISTANCE:
		var direction = (alvo - position).normalized()
		velocity = velocity.move_toward(direction * spd_m, ACCELERATION * delta)
		spd_m-=1
		if spd_m<=0:

			await get_tree().create_timer(0.2).timeout
			spd_m=spd_m2

		look_at(alvo) 
		move_and_slide()
	else:
		queue_free()
