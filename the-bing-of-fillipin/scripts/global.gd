extends Node2D
var salas:Array[PackedScene]=[
	preload("res://salas/Sala1.tscn"),
	preload("res://salas/Sala1.tscn")
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
	if dano==true:
		if Global.vida_c==0:
			Global.vida_v-=1
		else:
			Global.vida_c-=1
		Global.vida_g=Global.vida_c+Global.vida_c
		dano=false
#tiro
var tirospd=300 #spd tiro
var tiroext=2 #tempo de existencioa
