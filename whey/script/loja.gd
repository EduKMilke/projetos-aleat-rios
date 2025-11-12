extends Node2D
var aparece =-1
@onready var b_ini=$inicio
@onready var b_compra=$Button2
@onready var b_invt=$Button3
@onready var l_din=$Label
@onready var maquina = preload("res://obj/maquina.tscn")
@onready var invent= preload("res://obj/inventario.tscn")
@onready var peixe = $"../peixe"
var skin_selecionada_do_inventario: Dictionary = {}

var _imaq=null
var _iinv=null
func _ready() -> void:
	b_compra.position.x=get_viewport_rect().size.x /2-70
	b_invt.position.x=get_viewport_rect().size.x /2+10
	b_compra.position.y=get_viewport_rect().size.y /4
	b_invt.position.y=get_viewport_rect().size.y /4
	l_din.position.x=0
	l_din.position.y=0
	b_ini.position.x=get_viewport_rect().size.x/1.02
func _process(_delta: float) -> void:
	if aparece==1:
		b_compra.visible=true
		b_invt.visible=true
	else:
		b_compra.visible=false
		b_invt.visible=false
	
	l_din.text="dinheiro:"+str(Global.din)
	if aparece==1 and _imaq!=null:
		_imaq.queue_free()

	if aparece==1 and _iinv!=null:
		_iinv.queue_free()
func _on_button_pressed() -> void:
	aparece*=-1
func _on_button_2_pressed() -> void:
	aparece_m()
func _on_button_3_pressed() -> void:
	aparece_i()
func aparece_m()->void:
	_imaq=maquina.instantiate()
	aparece=-1
	add_child(_imaq)

	_imaq.position.x=get_viewport_rect().size.x/2
	_imaq.position.y=get_viewport_rect().size.y/2
func aparece_i()->void:
	_iinv=invent.instantiate()
	aparece=-1
	add_child(_iinv)
	if _iinv.has_signal("skin_selecionada"):
			_iinv.skin_selecionada.connect(_recebe_dados_inventario)
	_iinv.position.x=get_viewport_rect().size.x/2
	_iinv.position.y=get_viewport_rect().size.y/2
func atribui_spr()->void:
	var _spr1: Sprite2D = peixe.get_node("cabeca/Sprite2D")
	var _spr2: Sprite2D = peixe.get_node("meio/Sprite2D")
	var _spr3: Sprite2D = peixe.get_node("fim/Sprite2D")
	if is_instance_valid(_spr1) and is_instance_valid(_spr2) and is_instance_valid(_spr3) and skin_selecionada_do_inventario.size() > 0:
		if skin_selecionada_do_inventario.status==1:
			_spr3.texture = skin_selecionada_do_inventario.ini
			_spr2.texture = skin_selecionada_do_inventario.meio
			_spr1.texture = skin_selecionada_do_inventario.fim 
func _recebe_dados_inventario(ini_tex: Texture2D, meio_tex:Texture2D, fim_tex:Texture2D, status: int) -> void:
	skin_selecionada_do_inventario = {
		"ini": ini_tex,
		"meio": meio_tex,
		"fim": fim_tex,
		"status": status
		}
	atribui_spr()
