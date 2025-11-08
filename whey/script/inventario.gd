extends Node2D

@onready var ini=$Sprite2D2
@onready var meio=$Sprite2D3
@onready var fim=$Sprite2D4

var linc=Global.comum.size()
var lini=Global.incomum.size()
var linr=Global.raro.size()
var linl=Global.lendario.size()
var spr_tam=3

var atur: Array = [] 
var tm: int = 0 
var _glin: int = 0
var _gcol: int = 0

enum Categoria {COMUM, INCOMUM, RARO, LENDARIO}

var cate_atual: Categoria = Categoria.COMUM

func _ready() -> void:

	_troca_categoria(Categoria.COMUM)
func atlz_tex() -> void:

	if _glin == 0:
		ini.texture = null
		meio.texture = null
		fim.texture = null
		return
	if tm >= _glin:
		tm = 0
	var skin = atur[tm]
	if _gcol >= 4:

		ini.texture = skin[2]
		meio.texture = skin[1]
		fim.texture = skin[0] 
		
		ini.scale.x=spr_tam
		ini.scale.y=spr_tam
		meio.scale.y =spr_tam
		fim.scale.y=spr_tam
		meio.scale.x=spr_tam
		fim.scale.x= spr_tam
		
		var status = skin[_gcol - 1]
		var cor_efeito = Color.WHITE
		if status == 0:
			cor_efeito = Color.BLACK
		ini.modulate = cor_efeito
		meio.modulate = cor_efeito
		fim.modulate = cor_efeito

func _troca_categoria(nova_categoria: Categoria) -> void:
	cate_atual = nova_categoria
	match cate_atual:
		Categoria.COMUM:
			atur = Global.comum
		Categoria.INCOMUM:
			atur = Global.incomum
		Categoria.RARO:
			atur = Global.raro
		Categoria.LENDARIO:
			atur = Global.lendario
	tm = 0
	_glin = atur.size()

	_gcol = atur[0].size() if _glin > 0 and atur[0] is Array else 0

	atlz_tex()
func _troca_categoria2(nova_categoria: Categoria) -> void:
	cate_atual = nova_categoria
	match cate_atual:
		Categoria.COMUM:
			atur = Global.comum
		Categoria.INCOMUM:
			atur = Global.incomum
		Categoria.RARO:
			atur = Global.raro
		Categoria.LENDARIO:
			atur = Global.lendario
	tm = 0
	_glin = atur.size()
	_gcol = atur[0].size() if _glin > 0 and atur[0] is Array else 0

	atlz_tex()
func _on_button_pressed() -> void:
	
	if _glin == 0:
		ini.texture = null
		meio.texture = null
		fim.texture = null
		return
	if tm >= _glin:
		tm = 0
	var skin = atur[tm]
	if _gcol >= 4:
		ini.texture = skin[2]
		meio.texture = skin[1]
		fim.texture = skin[0] 

func _on_button_2_pressed() -> void:
	var proxima_categoria: Categoria
	match cate_atual:
		Categoria.COMUM:
			proxima_categoria = Categoria.INCOMUM
		Categoria.INCOMUM:
			proxima_categoria = Categoria.RARO
		Categoria.RARO:
			proxima_categoria = Categoria.LENDARIO
		Categoria.LENDARIO:
			proxima_categoria = Categoria.COMUM

	_troca_categoria(proxima_categoria)


func _on_button_3_pressed() -> void:
	var categoria_ant: Categoria
	match cate_atual:
		Categoria.COMUM:
			categoria_ant= Categoria.LENDARIO
		Categoria.INCOMUM:
			categoria_ant = Categoria.COMUM
		Categoria.RARO:
			categoria_ant = Categoria.INCOMUM
		Categoria.LENDARIO:
			categoria_ant= Categoria.RARO

	_troca_categoria2(categoria_ant)
