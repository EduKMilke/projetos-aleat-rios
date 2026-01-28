extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dire: int

@onready var spr = $Sprite2D
@onready var area = $Area2D/CollisionShape2D
@onready var coli = $CollisionShape2D

func _ready() -> void:
	randomize()
	dire = [-1, 1].pick_random()

func _physics_process(delta: float) -> void:
	if is_in_group("ini_azul"):
		if Global.inverte == 1:
			spr.modulate = Color("#00ffff")
			area.set_deferred("disabled", false)

		else:
			spr.modulate = Color("#00ffff45")
			area.set_deferred("disabled", true)


	if is_in_group("ini_red"):
		if Global.inverte == -1:
			spr.modulate = Color("#ff000e")
			area.set_deferred("disabled", false)

		else:
			spr.modulate = Color("#ff000e45")
			area.set_deferred("disabled", true)


	if is_on_wall():
		dire *= -1

	if Global.inverte == 1:
		if not is_on_floor():
			velocity += get_gravity() * delta
	elif Global.inverte == -1:
		if not is_on_ceiling():
			velocity -= get_gravity() * delta

	velocity.x = dire * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body != self:
		if body.has_method("morte"):
			body.morte()
