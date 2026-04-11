extends Area2D

var player = null
var spd = 200
var vida = 0
var vid_max = 16
var avoidance_force = 50 
var div = true
var podiv = 0

@onready var amo_m = preload("res://obj/inimigos/amoeba.tscn")

func _ready() -> void:
	vida = vid_max
	# Essencial para a sala encontrar este inimigo
	add_to_group("inimigo")

func _process(delta: float) -> void:
	# Lógica de movimentação (seu código original)
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	
	if player and global_position.distance_to(player.global_position) < 800:
		var direction_vector = (player.global_position - global_position).normalized()
		var separation = Vector2.ZERO
		var areas = get_overlapping_areas()
		
		for area in areas:
			if area.is_in_group("inimigo") and area != self:
				var diff = global_position - area.global_position
				separation += diff.normalized() * avoidance_force
		
		var final_velocity = (direction_vector * spd) + separation
		global_position += final_velocity * delta
		
		if podiv >= 2:
			div = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()

# --- DIVISÃO AO MORRER ---
func _exit_tree() -> void:
	# Como você disse que ele já é destruído quando a vida chega a 0,
	# o _exit_tree será chamado automaticamente pelo seu sistema de vida.
	if vida <= 0 and div == true and podiv < 3:
		var pai_da_sala = get_parent()
		
		if pai_da_sala:
			# Criamos os clones
			for i in 2:
				var i_amo = amo_m.instantiate()
				i_amo.vid_max = vid_max - 5
				i_amo.podiv = podiv + 1
				i_amo.global_position = global_position
				
				# Adiciona ao grupo ANTES de entrar na árvore
				i_amo.add_to_group("inimigo")
				
				# Adiciona como filho da sala usando call_deferred para evitar erros de física
				pai_da_sala.add_child.call_deferred(i_amo)
