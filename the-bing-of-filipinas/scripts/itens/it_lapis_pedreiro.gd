extends Area2D
var s_y: float = 0.0
var time: float = 0.0
func _ready() -> void:

	s_y = position.y 
func _process(delta: float) -> void:
	time += delta
	var movement = sin(time * 2.0) * 8.0
	
	
	position.y = s_y + movement


func _on_body_entered(body: Node2D) -> void:
	var mov = Input.get_vector("t_a", "t_d", "t_w", "t_s")
	if body.is_in_group("player"):
		Item.play()
		if mov == Vector2.ZERO:
			Global.dano_ti +=2
		elif Global.dano_ti>2 :
			Global.dano_ti-=2
		Interface.exibir_item("Lápis de Pedreiro", "Ganhe por ser preguiçoso")
		queue_free()
