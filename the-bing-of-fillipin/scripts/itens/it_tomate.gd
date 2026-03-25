extends Area2D
var s_y: float = 0.0
var time: float = 0.0

func _ready() -> void:

	s_y = position.y 
func _process(delta: float) -> void:
	time += delta
	var movement = sin(time * 2.0) * 8.0
	
	# Aplicamos na posição LOCAL
	position.y = s_y + movement
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.dano_ti= Global.dano_ti * 0.9
		Global.tiroc -= 0.2
		queue_free()
