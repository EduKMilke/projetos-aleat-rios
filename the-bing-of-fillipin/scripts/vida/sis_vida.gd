extends Node2D # Ou Control

const img = "res://assets/vidas/vidaV_1.png"
const img2 = "res://assets/vidas/vidaV_0.png"
const img3="res://assets/vidas/vidaV_0.png"
var vida_ver: Texture2D = null
var vida_ver_0:Texture2D=null
var vida_c:Texture2D=null
func _ready():
	vida_ver = load(img)
	vida_ver_0 = load(img2)
	vida_c=load(img3)
func _process(_delta):

	queue_redraw()
func _draw():
	var posicao = Vector2(0, 0)
	if Global.vida_g>Global.vida_maxg:
		if Global.vida_c>0:
			Global.vida_c-=1
		else:
			Global.vida_maxv-=1

	if vida_ver != null:
		for i in Global.vida_maxv:
			if i<Global.vida_v:
				draw_texture(vida_ver, posicao)
			else:
				draw_texture(vida_ver_0, posicao)
			posicao+=Vector2(30,0)

	if vida_c!=null:
		for i in Global.vida_c:
			draw_texture(vida_c, posicao)
			posicao+=Vector2(30,0)
