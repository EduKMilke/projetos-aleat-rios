extends Node2D

var salas:Array[PackedScene]=[
	preload("res://salas/Sala0.tscn"),
	preload("res://salas/Sala1.tscn"),
	preload("res://salas/Sala2.tscn"),
	preload("res://salas/Sala3.tscn"),
	preload("res://salas/Sala4.tscn"),
	preload("res://salas/Sala5.tscn"),
	preload("res://salas/Sala6.tscn"),
	preload("res://salas/Sala7.tscn"),
	preload("res://salas/Sala8.tscn"),
	preload("res://salas/Sala9.tscn"),
	preload("res://salas/Sala10.tscn"),
	preload("res://salas/Sala11.tscn"),
	preload("res://salas/Sala12.tscn"),
	preload("res://salas/Sala13.tscn"),
	preload("res://salas/Sala14.tscn"),
	preload("res://salas/Sala15.tscn"),
	preload("res://salas/Sala16.tscn"),
	preload("res://salas/Sala17.tscn"),
	preload("res://salas/Sala18.tscn"),
	preload("res://salas/Sala19.tscn"),
	preload("res://salas/Sala20.tscn"),
	preload("res://salas/Sala21.tscn"),
	preload("res://salas/Sala22.tscn"),
	preload("res://salas/Sala23.tscn"),
	preload("res://salas/Sala24.tscn"),
	preload("res://salas/Sala25.tscn"),
	preload("res://salas/Sala26.tscn"),
	preload("res://salas/Sala27.tscn"),
	preload("res://salas/Sala28.tscn"),
	preload("res://salas/Sala29.tscn"),
	preload("res://salas/Sala30.tscn")
]
var salaboss:Array[PackedScene]=[
	preload("res://salas/bosses/boss1.tscn"),
	preload("res://salas/bosses/boss2.tscn"),
	preload("res://salas/bosses/boss3.tscn"),
	preload("res://salas/bosses/boss4.tscn")
]
var itens=[
	preload("res://obj/itens/it_tomate.tscn"),
	preload("res://obj/itens/it_achocolatado.tscn"),
	preload("res://obj/itens/it_leite.tscn"),
	preload("res://obj/itens/it_tenis_branco.tscn"),
	preload("res://obj/itens/it_osmose.tscn"),
	preload("res://obj/itens/it_balde.tscn"),
	preload("res://obj/itens/it_cachecol.tscn"),
	preload("res://obj/itens/it_camelo.tscn"),
	preload("res://obj/itens/it_lapis_pedreiro.tscn"),
	preload("res://obj/itens/it_tenis_preto.tscn"),
	preload("res://obj/itens/it_canudo.tscn"),
	preload("res://obj/itens/it_mola.tscn"),
	preload("res://obj/itens/it_chapeu_anti_calvicie.tscn"),
	preload("res://obj/itens/it_coroa_do_legado.tscn"),
	preload("res://obj/itens/it_exoesqueleto.tscn"),
	preload("res://obj/itens/it_galinha_caipira.tscn"),
	preload("res://obj/itens/it_lapis.tscn"),
	preload("res://obj/itens/it_lapis_duplo.tscn"),
	preload("res://obj/itens/it_luckyton.tscn"),
	preload("res://obj/itens/it_miojobolizante.tscn"),
	preload("res://obj/itens/it_mitose.tscn"),
	preload("res://obj/itens/it_notebook_geriatrico.tscn"),
	preload("res://obj/itens/it_oculos.tscn"),
	preload("res://obj/itens/it_ovo.tscn"),
	preload("res://obj/itens/it_placa_mae.tscn"),
	preload("res://obj/itens/it_tenis_vermelho.tscn")
]
var player=null
var item=0
var mitose = false
var luckyton = false
var escala_tiro = 1.0
var lapis_duplo = false
var cachecol = false 
var canudo = false
var mola = false
var chance_cura: float=0.1
var total_kills = 0
var osmose=false

# player status
var inteligencia = 1
var mdano=1 
var mtiroc=1 
var plaspd=200 
var tiroc=0.5 * mtiroc 
var vida_maxv=3 
const vida_maxg=12 
var vida_v=3
var vida_c=1
var vida_g=4 # Definido direto como 4 para evitar leitura de nulos no primeiro frame
var dano=true
var t_dano=1 
var ener_ite=0
var espinho=true 

# tiro status
var tirospd=400 
var tiroext=2 
var dano_ti=1*mdano

func _ready() -> void:
	randomize()
	# Atualiza o valor real logo no começo de forma segura
	vida_g = vida_v + vida_c

# REMOVIDO O _process DAQUI PARA EVITAR O CRASH EM LOOP!

func menos_vida() -> void:
	if dano == false: 
		return

	if luckyton == true:
		var chance = randi_range(1, 100)
		if chance <= 10:
			tocar_tempo_invencivel() 
			return 

	perder_vida_real()

func perder_vida_real():
	dano = false 

	if vida_c > 0:
		vida_c -= 1
	else:
		vida_v -= 1
		
	vida_g = vida_v + vida_c
	if vida_g <= 0:
		
		player = get_tree().get_first_node_in_group("player")
		player.spr.play("morte")
		player.anim.play("morte")
		player.morte=true
		await player.anim.animation_finished
		vida_g = 3
		vida_v = 3 
		vida_c = 0
		get_tree().change_scene_to_file("res://salas/GameOver.tscn")
		dano = true
		
		return # Corta a função aqui já que mudou de cena

	await get_tree().create_timer(t_dano).timeout
	dano = true

func tocar_tempo_invencivel():
	dano = false
	await get_tree().create_timer(t_dano).timeout
	dano = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
			if event.keycode == KEY_F11:
				if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					DisplayServer.window_set_size(Vector2i(1152, 648))
					DisplayServer.window_set_position(Vector2i(int((DisplayServer.screen_get_size().x/2.0)-(DisplayServer.window_get_size().x/2.0)),int((DisplayServer.screen_get_size().y/2.0)-(DisplayServer.window_get_size().y/2.0))))
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
