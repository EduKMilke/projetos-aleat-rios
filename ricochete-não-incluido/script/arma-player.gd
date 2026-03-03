extends CharacterBody2D

const SPEED = 300.0
const target_name = "mira"

var mira = preload("res://obj/mira.tscn")
var bala = preload("res://obj/bala.tscn")
var target = null
var i_mira
var referencia_fraca = null
func _ready() -> void:
	i_mira = mira.instantiate()
	get_parent().call_deferred("add_child", i_mira)
	target = i_mira
func _process(_delta: float) -> void:
	detectar_ini()
	if is_instance_valid(target):
		look_at(target.global_position)
	if Input.is_action_just_pressed("ui_accept") and Global.mira == true:
		if Global.balas > 0:
			var i_bala = bala.instantiate()
			i_bala.global_position = global_position
			i_bala.rotation = rotation
			get_parent().add_child(i_bala)
			i_bala.alvo_atual = target
			Global.mira = false
			Global.balas -= 1
			referencia_fraca = weakref(i_bala)
	if referencia_fraca != null:
		var obj = referencia_fraca.get_ref()
		if obj == null:
			recriar_mira()
			referencia_fraca = null 
func recriar_mira():
	i_mira = mira.instantiate()
	get_parent().call_deferred("add_child", i_mira)
	target = i_mira
	Global.mira = true
func detectar_ini():
	var inimigos_vivos = get_tree().get_nodes_in_group("inimigos")
	if inimigos_vivos.size() == 0:
		var n=Global.n_fase
		Global.n_fase+=1
		get_tree().change_scene_to_file(Global.fases[n])
