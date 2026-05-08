extends StaticBody2D

var player = null
var ard = null # Boss (alvo)
var pode_atirar = true
var vida = 10 # Vida do Led


var laser_scene = preload("res://obj/boss/led_laser.tscn")

@onready var ani = $AnimatedSprite2D

func _ready() -> void:
	#Verifica se led entrou no grupo 
	if ard == null:
		var alvos = get_tree().get_nodes_in_group("Arduino")
		if alvos.size() > 0:
			ard = alvos[0]
		else:
			return

	#Verifica se o Player existe
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:

			return

	#Verifica a distância e o estado do disparo
	if is_instance_valid(player) and is_instance_valid(ard):
		var distancia = global_position.distance_to(player.global_position)
		
		if distancia < 800:
			if pode_atirar:
				print("Disparando laser no Boss em: ", ard.global_position)
				disparar_no_boss()
			else:
				# Se essa mensagem aparecer, a torre está esperando o tempo de recarga (await)
				pass 
		else:
			#Player muito longe
			pass
	await get_tree().create_timer(5).timeout
	queue_free()
func disparar_no_boss() -> void:
	if ani:
		ani.frame = 0 
		await get_tree().create_timer(0.5).timeout
		ani.frame = 1
		await get_tree().create_timer(0.5).timeout
	
	# 
	var novo_laser = laser_scene.instantiate()
	
	# 
	add_child(novo_laser)
	
	# 
	novo_laser.global_position = global_position
	
	if has_node("Raio"):
		$Raio.play()
	
	# Mira no Boss (Arduino)
	if novo_laser.has_method("configurar_alvo"):
		novo_laser.configurar_alvo(ard.global_position)
