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
		Global.luckyton = true
		Global.plaspd +=200
		Global.tiroc -=0.1
		Interface.exibir_item("Luckyton", "Partícula mediadora da sorte")
		queue_free()
