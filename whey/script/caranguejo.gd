extends CharacterBody2D

const MOVE_SPEED:float = 2.0

enum State { MOVING_TO_TARGET, IDLE, MOVING_TO_SLA }
var estado = State.MOVING_TO_TARGET

var screen_width: float
var screen_height: float
var alvo: Vector2 = Vector2.ZERO
var sla: float
var r_spr: int = randi_range(0, 1)
var sprs: Array[String] = ["parado2", "parado"]
@onready var spr: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sla = position.x 
	var viewport_size = get_viewport_rect().size
	screen_width = viewport_size.x
	screen_height = viewport_size.y
	spr.play("anda")
	alvo.x = randf_range(10.0, screen_width - 10.0)
	alvo.y = screen_height - 6

func _physics_process(delta: float) -> void:
	var step = MOVE_SPEED * delta * 60.0 
	match estado: #descobri que o match é tipo um switch
		State.MOVING_TO_TARGET:
			position = position.move_toward(alvo, step)
			if position.is_equal_approx(alvo):
				estado = State.IDLE
				spr.stop()
				spr.play(sprs[r_spr])
				espera_v()
				
		State.IDLE:
			pass
		State.MOVING_TO_SLA:
			var return_location = Vector2(sla, position.y) 
			position = position.move_toward(return_location, step)

			if position.is_equal_approx(return_location):
				queue_free()

func  espera_v() -> void:

	await get_tree().create_timer(3.2).timeout
	if estado == State.IDLE:
		estado = State.MOVING_TO_SLA
		spr.play("anda") 
