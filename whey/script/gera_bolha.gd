extends Node2D

@onready var bolha = preload("res://obj/boia.tscn")
@onready var polvo = preload("res://obj/polvo.tscn")
@onready var caran=preload("res://obj/caranguejo.tscn")
var l_tela = 0
var local = 0
var localpx=0
var localpy=0
var tempo_b = 0
var tempo_p=0
var al_tela = 0

func _ready() -> void:
	l_tela = (get_viewport_rect().size.x)
	al_tela = (get_viewport_rect().size.y)

	gerando_b()
	gerando_p()
	gerando_c()
func gerando_p() -> void:
	randomize()
	while true:

		var _lugarx =randf_range(-20,20+al_tela)
		var _lugary =randf_range(-20,al_tela+20)
		var _ly2=[-20,al_tela+20]
		var _lx2=[-20,l_tela+20]
		if _lugary>-20 and _lugary<al_tela+20:
			_lugarx=_lx2[randi_range(0,1)]
			
		else:
			_lugary=_ly2[randi_range(0,1)]
		tempo_p = randf_range(5, 8)
		await get_tree().create_timer(tempo_p).timeout
		var polvo_i = polvo.instantiate()
		add_child(polvo_i )
		polvo_i .position.x = _lugarx
		polvo_i .position.y = _lugary
func gerando_c()->void:
	while true:
		var possible_x_positions = [-10, l_tela + 10]
		var random_x = possible_x_positions[randi_range(0, 1)]
		var spawn_y = al_tela-6
		var caran_i = caran.instantiate()
		tempo_p = randf_range(5, 12)
		await get_tree().create_timer(tempo_p).timeout
		add_child(caran_i)
		caran_i.position.x = random_x
		caran_i.position.y = spawn_y

func gerando_b() -> void:
	while true:
		randomize()
		local = randf_range(10, l_tela)
		tempo_b = randf_range(0.5, 1)
		await get_tree().create_timer(tempo_b).timeout
		var bolha_i = bolha.instantiate()
		add_child(bolha_i)
		bolha_i.position.x = local
		bolha_i.position.y = al_tela
