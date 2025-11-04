extends Node2D

@onready var ini=$Sprite2D2
@onready var meio=$Sprite2D3
@onready var fim=$Sprite2D4
var linc=Global.comum.size()
var lini=Global.incomum.size()
var linr=Global.raro.size()
var linl=Global.lendario.size()

var col=Global.comum[0].size()
var coli=Global.incomum[0].size()
var colr=Global.raro[0].size()
var coll=Global.lendario[0].size()

var spr1=[null,null,null]
var atur=null
var tm=0
func _ready() -> void:

	ini.texture=Global.comum[0][0]
	meio.texture= Global.comum[0][1]
	fim.texture = Global.comum[0][2]
	atur=Global.comum
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	for i in range(linc):
		if Global.comum[i-1][col-1]:
			for a in range(col):
				print(Global.comum[i-1][a])
				if Global.comum[i-1][a] is int :
					return
				ini.texture=Global.comum[i-1][a]
func _on_button_2_pressed() -> void:
	tm+=1
	if tm>linc and atur==Global.comum:
		atur=Global.incomum
		tm=0
	elif tm>lini and atur==Global.incomum:
		atur=Global.raro
		tm=0
	elif tm>linr and atur==Global.raro:
		atur=Global.lendario
		tm=0
	elif tm>linl and atur==Global.lendario:
		atur=Global.comum
		tm=0
