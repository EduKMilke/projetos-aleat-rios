extends Node2D
var salas:Array[PackedScene]=[
	preload("res://salas/Sala0.tscn"),
	preload("res://salas/Sala1.tscn"),
	preload("res://salas/sala2.tscn"),
	preload("res://salas/sala3.tscn"),
	preload("res://salas/Sala4.tscn"),
	preload("res://salas/Sala5.tscn"),
	preload("res://salas/Sala6.tscn"),
	preload("res://salas/Sala7.tscn"),
	preload("res://salas/Sala8.tscn"),
	preload("res://salas/Sala9.tscn"),
	preload("res://salas/Sala10.tscn"),
	preload("res://salas/Sala11.tscn"),
	preload("res://salas/Sala12.tscn")
]
var salaboss:Array[PackedScene]=[
	preload("res://salas/bosses/boss1.tscn"),
	preload("res://salas/bosses/boss2.tscn"),
	preload("res://salas/bosses/boss3.tscn")
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
var item=0#qual é o item
#não sei
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
#player
var inteligencia = 1
var mdano=1 #multiplicador do dano
var mtiroc=1 #multiplicador do cooldown do tiro
var plaspd=200 #veloc do player
var tiroc=0.5 * mtiroc #coldown do tiro
var vida_maxv=3 #vida maxima vermelha
const vida_maxg=12 #vida maxima geral
var vida_v=3#vida vermelha preenchida obs toda vez que iniciado precisa ser menor ou igaula a o vida_maxv
var vida_c=1#vida cinza lá
var vida_g=vida_v+vida_c #soma das duas vidads
var dano=true
var t_dano=1 #tempo que player fica imortal dps de tomar dano
var ener_ite=0
var espinho=true #dano de espinho ativado
func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if vida_g <=0:
		vida_g = 3
		get_tree().change_scene_to_file("res://salas/GameOver.tscn")
		
func menos_vida() -> void:
	
	if dano == false: 
		return

	#Sorteio do Luckyton (10% de chance)
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
	
	
	await get_tree().create_timer(t_dano).timeout
	dano = true

func tocar_tempo_invencivel():
	dano = false
	await get_tree().create_timer(t_dano).timeout
	dano = true

#tiro
var tirospd=400 #spd tiro
var tiroext=2 #tempo de existencioa
var dano_ti=1*mdano#dano do tiro
#quando um boss morre


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
