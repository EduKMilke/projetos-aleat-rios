extends Node2D

@onready var bolha = preload("res://obj/boia.tscn")
var l_tela = 0
var local = 0
var tempo = 0
var al_tela = 0

func _ready() -> void:
	l_tela = get_viewport_rect().size.x
	al_tela = get_viewport_rect().size.y
	randomize()
	gerando()
func gerando() -> void:
	while true:
		local = randf_range(10, l_tela - 10)
		tempo = randf_range(0.5, 1)
		await get_tree().create_timer(tempo).timeout
		var bolha_i = bolha.instantiate()
		add_child(bolha_i)
		bolha_i.position.x = local
		bolha_i.position.y = al_tela
