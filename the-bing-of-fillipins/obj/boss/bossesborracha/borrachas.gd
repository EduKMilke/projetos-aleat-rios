extends CharacterBody2D
var a=true
var poca=preload("res://obj/Obstaculos/poca.tscn")
func _physics_process(delta: float) -> void:
	if a==true:
		a=false
		await get_tree().create_timer(1).timeout
		var i_poca=poca.instantiate()
		var sprite_poca = i_poca.get_node_or_null("Sprite2D")
		if sprite_poca:
			sprite_poca.modulate = Color(0.0, 0.0, 1.0, 1.0)
		i_poca.global_position=global_position
		get_tree().current_scene.add_child(i_poca)
		
		a=true
