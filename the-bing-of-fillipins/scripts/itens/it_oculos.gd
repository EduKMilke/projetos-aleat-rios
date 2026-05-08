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
		Item.play()
		Global.inteligencia+=0.3
		Interface.exibir_item("Óculos", "Todos sabem que óculos te deixam mais inteligênte")
		queue_free()
