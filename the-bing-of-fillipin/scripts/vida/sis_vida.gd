extends Node2D # Ou Control

const img = "res://assets/vidas/vidaV_1.png"
const img2 = "res://assets/vidas/vidaV_0.png"
var vida_ver: Texture2D = null
var vida_ver_0:Texture2D=null
func _ready():
	vida_ver = load(img)
	vida_ver_0 = load(img2)

func _process(_delta):

	queue_redraw()
func _draw():
	
	if vida_ver != null:
		var posicao = Vector2(0, 0)
		for i in Global.vida_maxv:
			if i<Global.vida_v:
				draw_texture(vida_ver, posicao)
			else:
				draw_texture(vida_ver_0, posicao)

			posicao+=Vector2(30,0)
