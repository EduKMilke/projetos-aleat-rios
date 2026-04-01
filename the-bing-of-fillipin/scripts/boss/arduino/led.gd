extends StaticBody2D

var player = null
var ard = null # Este agora é o seu BOSS (o alvo)
var pode_atirar = true
var vida = 10 # Vida da própria torre, se for destrutível

# Ajuste o caminho para a cena do seu laser
var laser_scene = preload("res://obj/boss/led_laser.tscn")

@onready var ani = $AnimatedSprite2D

func _ready() -> void:
	# 1. Verifica se a torre encontrou o grupo "Arduino"
	if ard == null:
		var alvos = get_tree().get_nodes_in_group("Arduino")
		if alvos.size() > 0:
			ard = alvos[0]
		else:
			return

	# 2. Verifica se o Player existe
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:

			return

	# 3. Verifica a distância e o estado do disparo
	if is_instance_valid(player) and is_instance_valid(ard):
		var distancia = global_position.distance_to(player.global_position)
		
		if distancia < 800:
			if pode_atirar:
				print("🚀 DISTÂNCIA OK: Disparando laser no Boss em: ", ard.global_position)
				disparar_no_boss()
			else:
				# Se essa mensagem aparecer, a torre está esperando o tempo de recarga (await)
				pass 
		else:
			# O player está longe demais da torre
			pass
	await get_tree().create_timer(5).timeout
	queue_free()
func disparar_no_boss() -> void:
	if ani:
		ani.frame = 1 
		await get_tree().create_timer(0.5).timeout
		ani.frame = 2
		await get_tree().create_timer(0.5).timeout
	
	# Cria o laser
	var novo_laser = laser_scene.instantiate()
	
	# Adiciona na cena principal para o laser não se mover com a torre
	add_child(novo_laser)
	
	# O laser nasce na posição desta torre
	novo_laser.global_position = global_position
	
	if has_node("Raio"):
		$Raio.play()
	
	# Mira no Boss (Arduino)
	if novo_laser.has_method("configurar_alvo"):
		novo_laser.configurar_alvo(ard.global_position)
