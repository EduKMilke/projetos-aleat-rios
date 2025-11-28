extends Node2D

var d_x = 0    
var d_y = 0    

func _physics_process(delta: float) -> void:
	var direction_vector = Vector2(d_x, d_y).normalized()
	position += direction_vector * Global.tirospd * delta
	await get_tree().create_timer(Global.tiroext).timeout
	queue_free()
