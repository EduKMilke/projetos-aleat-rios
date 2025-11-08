extends Node2D
var aparece =-1
@onready var b_ini=$inicio
@onready var b_compra=$Button2
@onready var b_invt=$Button3
@onready var l_din=$Label
@onready var maquina = preload("res://obj/maquina.tscn")
@onready var invent= preload("res://obj/inventario.tscn")

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

	_iinv.position.x=get_viewport_rect().size.x/2
	_iinv.position.y=get_viewport_rect().size.y/2
