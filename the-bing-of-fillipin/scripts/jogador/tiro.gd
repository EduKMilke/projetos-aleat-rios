extends Node2D

var d_x = 0    
var d_y = 0    

func _physics_process(delta: float) -> void:
	var direction_vector = Vector2(d_x, d_y).normalized()
	position += direction_vector * Global.tirospd * delta
	await get_tree().create_timer(Global.tiroext).timeout
	queue_free()


func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("inimigo"):
		body.vida-=Global.dano_ti
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("inimigo"):
		area.vida-=Global.dano_ti
		queue_free()
