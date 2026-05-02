extends CharacterBody2D

var tiro = preload("res://obj/tiros_dano_player/tiro_quase_segue_eletrico.tscn")
var speed = 200
var vida = 70
var vida_a = vida
var player = null
var move = true
var barra_vida = preload("res://obj/boss/barra_vida_boss.tscn")
var _ibar_vida
var _progress_bar

func _ready() -> void:
	_ibar_vida = barra_vida.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida
	

func _physics_process(delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if player != null and global_position.distance_to(player.global_position) < 800:
		
		if vida != vida_a:
			_progress_bar.value = vida
			speed += (vida_a - vida) * 10
			vida_a = vida
	if vida<=0:
		_ibar_vida.queue_free()
		morrer()
@onready var alca=preload("res://scripts/boss/alcpao.tscn")
func morrer():
	var i_alca = alca.instantiate()
	var pos_morte = global_position # Pega a posição enquanto ainda está na árvore
	
	get_tree().current_scene.add_child(i_alca)
	i_alca.global_position = pos_morte
	
	queue_free() # Deleta o boss DEPOIS de criar o item
