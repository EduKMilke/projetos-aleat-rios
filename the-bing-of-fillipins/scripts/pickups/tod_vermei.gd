extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Global.vida_v < Global.vida_maxv:
		Global.vida_v+=1
		queue_free()
	
	
