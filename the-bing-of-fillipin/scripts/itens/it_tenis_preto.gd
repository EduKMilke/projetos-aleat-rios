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
	
		if Global.vida_v <=1:
			Global.plaspd +=50
		else :
			Global.plaspd-=50
		Interface.exibir_item("Tênis Preto", "Corra como se o Eduardo estivesse atrás de você!")
		Item.play()
		queue_free()
		
