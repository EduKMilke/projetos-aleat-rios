extends CharacterBody2D

var vida = 70 * Global.inteligencia
var barra_vida = preload("res://obj/boss/barra_vida_boss.tscn")
@onready var alca = preload("res://scripts/boss/alcpao.tscn")
var player = null
var tiro = preload("res://obj/tiros_dano_player/tiro_quase_segue_rastro.tscn")
var speed = 50
var _ibar_vida
var _progress_bar
var b = true
var dire = Vector2.ZERO
@onready var sprite = $Sprite2D


var timer_acao : Timer
enum Acoes { SEGUIR, ATIRAR, ALTERAR_STATUS }
var acao_atual = Acoes.SEGUIR 

func _ready() -> void:
	_ibar_vida = barra_vida.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida
	


func _physics_process(delta: float) -> void:
	if vida <= 0:
		morrer()
		return
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		
	if player != null and global_position.distance_to(player.global_position) < 800:

		add_collision_exception_with(player)
		if b == true:
			get_tree().current_scene.add_child(_ibar_vida)
			configurar_timer_acoes()
			b = false

		dire = global_position.direction_to(player.global_position)
		velocity = dire * speed
		move_and_slide()

func configurar_timer_acoes() -> void:
	timer_acao = Timer.new()
	timer_acao.wait_time = 2.0
	timer_acao.autostart = true
	timer_acao.one_shot = false
	timer_acao.timeout.connect(_escolher_acao_aleatoria)
	add_child(timer_acao)

func _escolher_acao_aleatoria() -> void:
	var escolha = randi() % 3
	acao_atual = escolha as Acoes
	
	match acao_atual:
		Acoes.ATIRAR:
			criar_tiro()
		Acoes.ALTERAR_STATUS:
			alterar_status_player()

func criar_tiro() -> void:
	
	if tiro:
		var corale = Color(randf(), randf(), randf(), 1.0)
		var cor_a = corale
		sprite.modulate  = cor_a
		var novo_tiro = tiro.instantiate()
		novo_tiro.global_position = global_position
		if "cor" in novo_tiro:
			novo_tiro.cor = corale 
		get_tree().current_scene.add_child(novo_tiro)

func alterar_status_player() -> void:
	Global.plaspd*=-1

func morrer():
	var i_alca = alca.instantiate()
	var pos_morte = global_position 
	Global.plaspd=200
	get_tree().current_scene.add_child(i_alca)
	i_alca.global_position = pos_morte
	
	queue_free() 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()

func tomar_dano(quantidade: int) -> void:
	vida -= quantidade
	if _progress_bar:
		_progress_bar.value = vida
