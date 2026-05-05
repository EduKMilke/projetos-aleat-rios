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
	if body.is_in_group("player"):
		Item.play()

		Global.dano_ti+=1
		Global.mtiroc -= 0.25
		Global.tiroext +=1
		Global.inteligencia -=1
		Interface.exibir_item("Notebook Geriátrico", "Esquenta tanto que da pra frita um ovo nele")
		queue_free()
