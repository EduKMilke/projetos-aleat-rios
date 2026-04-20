extends Area2D

var player = null
var spd = 150
var vida = 0
var vid_max = 16
var avoidance_force = 50 
var div = true
var podiv = 0

@onready var amo_m = preload("res://obj/inimigos/amoeba.tscn")


func _ready() -> void:
	vida = vid_max
	add_to_group("inimigo")

# Função para ser chamada quando a amoeba levar dano
func tomar_dano(quantidade: int):
	vida -= quantidade


func morrer():

	
	# Verificamos se ele ainda pode se dividir
	if podiv < 2: 
		var pai_da_sala = get_parent()
		
		# Carregamos a cena aqui dentro para evitar erros de dependência circular
		var amoeba_scene = load("res://obj/inimigos/amoeba.tscn")
		
		if amoeba_scene:
			for i in 2:
				var i_amo = amoeba_scene.instantiate()
				
				# CONFIGURAÇÃO DOS CLONES
				i_amo.podiv = podiv + 1
				i_amo.vid_max = vid_max - 5
				i_amo.vida = i_amo.vid_max # CRITICAL: Garante que o clone não nasça com 0 de vida
				i_amo.global_position = global_position + Vector2(randf_range(-40, 40), randf_range(-40, 40))
				
				# Adiciona à sala
				pai_da_sala.add_child.call_deferred(i_amo)

	queue_free()

func _process(delta: float) -> void:
	# --- Sua lógica de movimento original ---
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

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
func _exit_tree() -> void:
		morrer()
