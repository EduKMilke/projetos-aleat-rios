extends Area2D

var player = null
var spd = 200
var vida = 5
var avoidance_force = 50 # Força para empurrar o vizinho
var knockback = Vector2.ZERO

func _process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	
	if player and global_position.distance_to(player.global_position) < 800:
		var direction_vector = (player.global_position - global_position).normalized()
		
		# --- LÓGICA DE SEPARAÇÃO ---
		var separation = Vector2.ZERO
		# Pegamos todas as áreas que estão sobrepostas a esta
		var areas = get_overlapping_areas()
		
		for area in areas:
			if area.is_in_group("inimigo"):
				# Calcula um vetor que aponta para o lado oposto do outro inimigo
				var diff = global_position - area.global_position
				# Quanto mais perto, mais forte ele empurra
				separation += diff.normalized() * avoidance_force
		
		# Somamos a direção do player + a força de separação
		var final_velocity = (direction_vector * spd) + separation + knockback
		global_position += final_velocity * delta
		knockback = knockback.move_toward(Vector2.ZERO, 1500 * delta)
		# ---------------------------

	if vida <= 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if Global.mola == true:
		var direcao_empurrao = (global_position - body.global_position).normalized()
		knockback = direcao_empurrao * 1800
		Global.menos_vida()
	else:
		Global.menos_vida()
