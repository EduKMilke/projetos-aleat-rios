extends CharacterBody2D

@onready var timer_ataque = $TimerAtaque
@onready var anim = $AnimatedSprite2D
@onready var locspw1 = $Spawns_i/CE
@onready var locspw2 = $Spawns_i/CD

var speed = 200
var vida = 70 * Global.inteligencia
var vida_a = vida
var player = null
var barra_ativa = false
var spawnando_inimigos = false

var argola = preload("res://obj/boss/onda_dano.tscn")
var argolap = preload("res://obj/boss/onda_danoparar.tscn")
@onready var barra_vida_scene = preload("res://obj/boss/barra_vida_boss.tscn")
@onready var alca = preload("res://scripts/boss/alcpao.tscn")

var inimigos = [
	preload("res://obj/inimigos/atirador.tscn"),
	preload("res://obj/inimigos/bola.tscn"),
	preload("res://obj/inimigos/grampeador.tscn"),
	preload("res://obj/inimigos/i_laser.tscn"),
	preload("res://obj/inimigos/rastejador.tscn"),
	preload("res://obj/inimigos/seguidor.tscn")
]

var _ibar_vida
var _progress_bar

func _ready() -> void:
	add_to_group("inimigo")
	await get_tree().create_timer(2).timeout 
	_ibar_vida = barra_vida_scene.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida
	
	timer_ataque.wait_time = 5.0
	timer_ataque.start()

func _physics_process(_delta):
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")
		return
		
	if global_position.distance_to(player.global_position) < 800:
		if not barra_ativa and _ibar_vida != null:
			get_tree().current_scene.add_child(_ibar_vida)
			barra_ativa = true
			iniciar_ciclo_reforcos()
			
		if barra_ativa and is_instance_valid(_progress_bar):
			_progress_bar.value = vida
			
		if vida != vida_a:
			speed += (vida_a - vida) * 10
			vida_a = vida
			
	if vida <= 0:
		morrer()

func iniciar_ciclo_reforcos():
	if spawnando_inimigos: return
	spawnando_inimigos = true
	
	while vida > 0:
		await get_tree().create_timer(5.0).timeout
		var qtd_inimigos = get_tree().get_nodes_in_group("inimigo").size()
		
		if qtd_inimigos < 20: 
			spawnar()

func spawnar():
	var cena_inimigo = inimigos.pick_random()
	if cena_inimigo:
		var novo_inimigo = cena_inimigo.instantiate()
		# Escolhe aleatoriamente entre locspw1 e locspw2
		var ponto = [locspw1, locspw2].pick_random()
		get_parent().add_child(novo_inimigo)
		novo_inimigo.global_position = ponto.global_position
		novo_inimigo.add_to_group("inimigo")

func _on_timer_ataque_timeout() -> void:
	if vida > 0: 
		atacar()
		timer_ataque.start(5.0)

func atacar():
	var escolher = randi_range(1, 2)
	anim.play("ataque")
	
	var cena_onda = argola if escolher == 1 else argolap
	var i_onda = cena_onda.instantiate()
	get_parent().add_child(i_onda)
	i_onda.global_position = global_position
	
	await get_tree().create_timer(2.0).timeout
	anim.play("default")

func morrer():
	if is_instance_valid(_ibar_vida): _ibar_vida.queue_free()
	var i_alca = alca.instantiate()
	get_parent().add_child(i_alca)
	i_alca.global_position = global_position
	queue_free()
