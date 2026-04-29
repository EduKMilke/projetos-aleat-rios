extends Node2D

var bot=0
@onready var lab1=$Label
@onready var lab2=$Label2
@onready var lab3=$Label3
@onready var anim=$AnimationPlayer
func _ready() -> void:
	get_tree().root.content_scale_factor = 1

func _process(delta: float) -> void:

	if Input.is_action_just_pressed("ui_up"):
		bot+=1
	if Input.is_action_just_pressed("ui_down"):
		bot-=1
	if bot>2:
		bot=0
	if bot<0:
		bot=2
	match bot:
		0:
			lab1.modulate="#ffff00"
			lab2.modulate="#ffffff"
			lab3.modulate="#ffffff"
			$Jogar.frame = 1
			$Creditos.frame = 0
			$Sair.frame = 0
			if Input.is_action_just_pressed("ui_accept"):
				anim.play("escuro")
				await anim.animation_finished
				get_tree().change_scene_to_file("res://obj/world.tscn")

		1:
			lab2.modulate="#ffff00"
			lab1.modulate="#ffffff"
			lab3.modulate="#ffffff"
			$Creditos.frame = 1
			$Jogar.frame = 0
			$Sair.frame = 0
			if Input.is_action_just_pressed("ui_accept"):
				get_tree().quit()
			
		2:
			lab3.modulate="#ffff00"
			lab2.modulate="#ffffff"
			lab1.modulate="#ffffff"
			$Sair.frame = 1
			$Creditos.frame = 0
			$Jogar.frame = 0
			if Input.is_action_just_pressed("ui_accept"):
				anim.play("escuro")
				await anim.animation_finished
				get_tree().change_scene_to_file("res://salas/Menus/Creditos.tscn")
			
