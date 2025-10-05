extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(_delta: float) -> void:
	var input := int(Input.is_action_pressed("ui_up"))
	var direc := Vector2.LEFT.rotated(rotation) * input
	if input:
		velocity= direc * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	if Input.is_action_pressed("ui_right"):
		rotation += 0.2
	if Input.is_action_pressed("ui_left"):
		rotation -= 0.2
	move_and_slide()
