extends Area2D
@onready var portal_a=$Area2D
@onready var spr_a=$Area2D/Sprite2D
@onready var portal_v=$Area2D2
@onready var spr_v=$Area2D2/Sprite2D
var tp: bool=true
func _ready() -> void:
	pass
func _process(_delta: float) -> void:
	if Global.inverte==-1:
		spr_a.modulate="#00ffff45"
	else:
		spr_a.modulate="#00ffffff"
	if Global.inverte==1:
		spr_v.modulate="#ff000e45"
	else:
		spr_v.modulate="#ff000eff"
func _on_body_entered(body: Node2D) -> void:
	print(body)
	if tp==true:
		if body is CharacterBody2D:
			if Global.inverte==1:
				body.global_position=portal_a.global_position
			elif Global.inverte==-1:
				body.global_position=portal_v.global_position
		tp=false
func _on_body_exited(body: Node2D) -> void:
	tpvalido(body)
func tpvalido(body:Node2D):
	if body is CharacterBody2D:
		if tp==false:
			tp=true
