extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var spr=$AnimatedSprite2D
@onready var coli=$CollisionShape2D
@onready var camera=$Camera2D
var morto = false
@export var fixed_y_position: float = -150.00

func _ready():
	camera.global_position.y = fixed_y_position
func _process(_delta: float) -> void:
	if camera.global_position.y != fixed_y_position:
		camera.global_position.y = fixed_y_position
	if Input.is_action_just_pressed("ui_accept"):
		fixed_y_position*=-1
func _physics_process(delta: float) -> void:
	
	if morto == false:
		if Global.inverte == -1:
			if spr == $AnimatedSprite2D: spr.hide()
			spr = $AnimatedSprite2D2
			spr.show()
		else:
			if spr == $AnimatedSprite2D2: spr.hide()
			spr = $AnimatedSprite2D
			spr.show()

		var direction := Input.get_axis("t_A", "t_D")
		if not is_on_floor() and Global.inverte == 1:
			velocity += get_gravity() * delta * Global.inverte
		if not is_on_ceiling() and Global.inverte == -1:
			velocity += get_gravity() * delta * Global.inverte
		if not is_on_ceiling() and not is_on_floor():
			spr.play("pulo")
		else:
			if direction != 0:
				spr.play("andar")
			else:
				spr.play("parado")

		var pode_pular = (is_on_floor() if Global.inverte > 0 else is_on_ceiling())
		if Input.is_action_pressed("t_W") and pode_pular and Global.inverte == 1:
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_pressed("t_S") and pode_pular and Global.inverte == -1:
			velocity.y = JUMP_VELOCITY * -1

		if direction:
			velocity.x = direction * SPEED
			spr.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity += get_gravity() * delta 
		velocity.x = 0
	move_and_slide()
func morte() -> void:
	if morto: 
		return
	morto = true
	coli.disabled=true
	collision_layer = 0
	collision_mask = 0
	velocity.y = JUMP_VELOCITY 
	spr.play("pulo")
	await get_tree().create_timer(2.0).timeout
	queue_free()
