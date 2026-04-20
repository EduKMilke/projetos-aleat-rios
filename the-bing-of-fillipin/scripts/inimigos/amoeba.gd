extends Area2D

var player = null
var spd = 150
var vida = 0
var vid_max = 16
var avoidance_force = 1000 
var podiv = 0 

const AMOEBA_SCENE = preload("res://obj/inimigos/amoeba.tscn")

func _ready() -> void:
	vida = vid_max
	add_to_group("inimigo")

func tomar_dano(quantidade: int):
	vida -= quantidade
	if vida <= 0:
		queue_free()

func _exit_tree() -> void:
	if vida <= 0 and podiv < 2:
		var pai_da_sala = get_parent()
		var spawn_pos = global_position
		
		if pai_da_sala:
			for i in 2:
				var clone = AMOEBA_SCENE.instantiate()
				clone.podiv = podiv + 1
				clone.vid_max = vid_max - 5
				clone.vida = clone.vid_max
				
				pai_da_sala.add_child.call_deferred(clone)
				clone.global_position = spawn_pos + Vector2(randf_range(-20, 20), randf_range(-20, 20))

func _process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	
	if player and global_position.distance_to(player.global_position) < 800:
		var direction_vector = (player.global_position - global_position).normalized()
		var separation = Vector2.ZERO
		var vizinhos = get_overlapping_areas()
		
		for area in vizinhos:
			if area.is_in_group("inimigo") and area != self:
				var diff = global_position - area.global_position
				var dist = diff.length()
				if dist > 0:
					separation += (diff.normalized() / dist) * avoidance_force
		
		var velocity = (direction_vector * spd) + separation
		global_position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Global.has_method("menos_vida"):
			Global.menos_vida()
