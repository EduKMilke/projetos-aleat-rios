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
var plaspd=300.00 #veloc do player
var tiroc=0.5 #coldown do tiro

#tiro
var tirospd=300 #spd tiro
var tiroext=2 #tempo de existencioa
