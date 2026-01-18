extends Node2D
var salas:Array[PackedScene]=[
	preload("res://salas/Sala0.tscn"),
	preload("res://salas/Sala0.tscn"),
	preload("res://salas/Sala2.tscn")
]
var salaboss:Array[PackedScene]=[
	preload("res://salas/bosses/boss1.tscn"),
	preload("res://salas/bosses/boss1.tscn")
]

#player
var plaspd=20000 #veloc do player
var tiroc=0.5 #coldown do tiro

var vida_maxv=3 #vida maxima vermelha
const vida_maxg=12 #vida maxima geral
var vida_v=3#vida vermelha preenchida obs toda vez que iniciado precisa ser menor ou igaula a o vida_maxv
var vida_c=1#vida cinza lá
var vida_g=vida_v+vida_c #soma das duas vidads
var dano=true
var t_dano=1 #tempo que player fica imortal dps de tomar dano
func menos_vida()->void:
	if dano == true: 
		dano = false
		if vida_c > 0:
			vida_c -= 1
		else:
			vida_v -= 1
		vida_g = vida_v + vida_c
#tiro
var tirospd=300 #spd tiro
var tiroext=2 #tempo de existencioa

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
