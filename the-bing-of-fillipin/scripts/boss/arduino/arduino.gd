extends CharacterBody2D

var player = null
var acao = 0
var spd = 100.0 # Ajustei para 100, pois 5000 é rápido demais para CharacterBody2D
var direcao_atual = Vector2.ZERO
var y_ale=0
var led=preload("res://obj/boss/led.tscn")
var pled=true
var tiro=preload("res://obj/tiros_dano_player/tiro_segue.tscn")
var a=true
var b=true
var vida=40
var barra_vida = preload("res://obj/boss/barra_vida_boss.tscn")
var _ibar_vida
var _progress_bar
func _ready() -> void:
	_ibar_vida = barra_vida.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida

	escolher_nova_acao()

func _physics_process(delta: float) -> void:
	_progress_bar.value = vida
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return 

	if global_position.distance_to(player.global_position) < 800:
		if b == true:
			get_tree().current_scene.add_child(_ibar_vida)
			b = false
		match acao:
			0:if a==true: 
				atira()
			1: anda_d()
			2: anda_e()
			3:
				if pled==true:
					spw_led()
			4:if a==true: 
				atira()
		velocity = direcao_atual
		move_and_slide()

# Funções que definem a direção
func parado():
	direcao_atual = Vector2.ZERO

func anda_d():
	direcao_atual = Vector2(spd, y_ale)

func anda_e():
	direcao_atual = Vector2(-spd, y_ale)

func spw_led():
	var x_min = 20
	var x_max = 800
	var y_min = 20
	var y_max = 450
	pled=false
	for i in 4:
		var i_led = led.instantiate()
		var x_random = randf_range(x_min, x_max)
		var y_random = randf_range(y_min, y_max)
		i_led.global_position = Vector2(x_random, y_random)
		get_tree().current_scene.add_child(i_led)
	await get_tree().create_timer(2).timeout
	pled=true
func atira():
	a=false
	var i_tiro = tiro.instantiate()
	i_tiro.global_position = global_position
	get_tree().current_scene.add_child(i_tiro)
	i_tiro.speed=150
	await get_tree().create_timer(2).timeout
	a=true
func escolher_nova_acao():
	acao = randi_range(0, 4)
	y_ale=randf_range(-100,100)
	await get_tree().create_timer(1).timeout
	escolher_nova_acao()
