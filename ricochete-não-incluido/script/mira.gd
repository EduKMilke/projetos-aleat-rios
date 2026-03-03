extends CharacterBody2D

@export var target_name: String = "Player" # Certifique-se que o nome do nó do Player seja este
@export var rotation_speed: float = 2.0
@export var radius: float = 180.0

var angle: float = 0.0
var target: Node2D = null

func _physics_process(delta):
	if !Global.mira==false:
		if not is_instance_valid(target):
			target = get_parent().find_child(target_name, true, false)
		
		if target:
			angle += rotation_speed * delta
			var current_arc = (sin(angle)) / 3.0 * PI

			var direction = Vector2(cos(current_arc), sin(current_arc))
			var target_pos = target.global_position + (direction * radius)
			global_position = target_pos
	else:
			queue_free()
