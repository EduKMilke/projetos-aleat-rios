extends StaticBody2D

var player = null
var laser_scene = preload("res://obj/inimigos/laser.tscn")
var pode_atirar = true
var vida=7
@onready var ani = $AnimatedSprite2D

func _process(_delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if vida<=0:
		queue_free()
	if player != null and global_position.distance_to(player.global_position) < 800:
		if pode_atirar:
			disparar_sequencia()

func disparar_sequencia() -> void:
	pode_atirar = false
	
	ani.frame = 1 
	await get_tree().create_timer(1.0).timeout
	
	ani.frame = 2
	await get_tree().create_timer(1.0).timeout
	
	var novo_laser = laser_scene.instantiate()
	var posicao_alvo = player.global_position
	await get_tree().create_timer(1.0).timeout
	add_child(novo_laser)
	$Raio.play()
	
	if novo_laser.has_method("configurar_alvo"):
		novo_laser.configurar_alvo(posicao_alvo)
	
	await get_tree().create_timer(1.0).timeout
	pode_atirar = true
