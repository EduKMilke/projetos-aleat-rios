extends Area2D

var bateu = false

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not bateu:
		bateu = true
		Global.plaspd -= 100
		var player_sprite = body.get_node_or_null("AnimatedSprite2D")
		if player_sprite:
			player_sprite.modulate = Color(2.5, 2.5, 2.5, 1.0)
		hide()
		await get_tree().create_timer(3).timeout
		Global.plaspd += 100
		if is_instance_valid(body) and is_instance_valid(player_sprite):
			player_sprite.modulate = Color.WHITE
			
		queue_free()
