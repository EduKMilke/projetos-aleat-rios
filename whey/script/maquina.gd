extends Node2D

@onready var comp = $Button
@onready var anim = $AnimationPlayer


@onready var cab: Sprite2D = $AnimationPlayer/cabeca
@onready var meio: Sprite2D = $AnimationPlayer/meio
@onready var fim: Sprite2D = $AnimationPlayer/fim

@onready var bola = $AnimationPlayer/AnimatedSprite2D
var alea = 0
var cor = null
var anum: int
var col = 0
var lin = 0
const adddin = 5
const preco = 15

func _ready() -> void:
	randomize()
	position=Vector2(0,0)
func _on_button_pressed() -> void:

	if Global.din >= preco:
		Global.din -= preco
		anim.play("abrir")
		anum = randi_range(1, 100)
		
		var array1: Array = [] 

		if anum <= 40:
			array1 = Global.comum
			cor = "#ffffff"
		elif anum <= 70:
			array1 = Global.incomum
			cor = "#00b362"
		elif anum <= 85:
			array1 = Global.raro
			cor = "#00b4e6"
		elif anum <= 100:
			array1 = Global.lendario
			cor = "#ffff00"

		lin = array1.size()
		col = array1[0].size()
		alea = randi_range(0, lin - 1)
		var stat = col - 1
		if array1[alea][stat] == 1:
			Global.din += adddin
		else:
			array1[alea][stat] = 1
		cab.texture = array1[alea][0]
		meio.texture = array1[alea][1]
		fim.texture = array1[alea][2]
		bola.modulate = Color(cor) 
