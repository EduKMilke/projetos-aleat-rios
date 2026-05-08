extends CharacterBody2D

@onready var alca = preload("res://scripts/boss/alcpao.tscn")
@onready var led = preload("res://obj/boss/led.tscn")
@onready var tiro = preload("res://obj/tiros_dano_player/tiro_segue.tscn")
@onready var barra_vida_scene = preload("res://obj/boss/barra_vida_boss.tscn")

var player = null
var acao = 0
var spd = 150.0 
var direcao_atual = Vector2.ZERO
var y_ale = 0
var pled = true
var a = true
var b = true
var vida = 50 * Global.inteligencia

var _ibar_vida
var _progress_bar

func _ready() -> void:
	_ibar_vida = barra_vida_scene.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida
	escolher_nova_acao()

func _physics_process(_delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	if not is_instance_valid(player):
		return 

	if global_position.distance_to(player.global_position) < 800:
		if b:
			get_tree().current_scene.add_child(_ibar_vida)
			b = false
		
		_progress_bar.value = vida
		
		match acao:
			0, 4: if a: atira()
			1: direcao_atual = Vector2(spd, y_ale)
			2: direcao_atual = Vector2(-spd, y_ale)
			3: if pled: spw_led()
			
		velocity = direcao_atual
		move_and_slide()

	if vida <= 0:
		morrer()

func spw_led():
	pled = false
	for i in 4:
		var i_led = led.instantiate()
		get_parent().add_child(i_led)
		
		var offset_x = randf_range(-350, 350)
		var offset_y = randf_range(-250, 250)
		
		i_led.global_position = global_position + Vector2(offset_x, offset_y)
		
	await get_tree().create_timer(2.0).timeout
	pled = true

func atira():
	a = false
	var i_tiro = tiro.instantiate()
	get_parent().add_child(i_tiro)
	i_tiro.global_position = global_position
	i_tiro.speed = 150
	await get_tree().create_timer(2.0).timeout
	a = true

func escolher_nova_acao():
	acao = randi_range(0, 4)
	y_ale = randf_range(-100, 100)
	await get_tree().create_timer(1.5).timeout
	if vida > 0: escolher_nova_acao()

func morrer():
	if is_instance_valid(_ibar_vida): _ibar_vida.queue_free()
	var i_alca = alca.instantiate()
	get_parent().add_child(i_alca)
	i_alca.global_position = global_position
	queue_free()
