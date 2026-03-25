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
		Global.mtiroc=1.5
		Global.mdano=1.5
		Global.dano_ti+=1
		Global.vida_maxv+=2
		Global.vida_v+=2
		Global.tiroc -= 0.1
		Global.tiroext +=1
		Global.tirospd +=1
		queue_free()
