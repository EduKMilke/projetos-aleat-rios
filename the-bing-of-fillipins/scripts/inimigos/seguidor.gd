extends Area2D

var player = null
var spd = 100
var vida = 5
var separation_speed = 60 # Velocidade da separação 
var knockback = Vector2.ZERO

func _process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	
	if player and global_position.distance_to(player.global_position) < 800:
		var direction_to_player = (player.global_position - global_position).normalized()
		
		# --- LÓGICA DE SEPARAÇÃO MELHORADA --- n sei como tá funcionando -_('_')_-
		var separation_vector = Vector2.ZERO
		var areas = get_overlapping_areas()
		var count = 0
		
		for area in areas:
			if area.is_in_group("inimigo") and area != self:
				var diff = global_position - area.global_position
				if diff.length() > 0:
					separation_vector += diff.normalized() / diff.length()
					count += 1
		
		if count > 0:
			separation_vector = (separation_vector / count).normalized() * separation_speed
		var target_velocity = (direction_to_player * spd) + separation_vector

		global_position += (target_velocity + knockback) * delta
		knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)

	if vida <= 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Global.mola:
			var direcao_empurrao = (global_position - body.global_position).normalized()
			knockback = direcao_empurrao * 600
		Global.menos_vida()
