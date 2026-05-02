extends Control


var cont=0
func _ready() -> void:
	get_tree().root.content_scale_factor = 1

func _process(delta: float) -> void:

	if Input.is_action_just_pressed("ui_up"):
		cont+=1
	if Input.is_action_just_pressed("ui_down"):
		cont-=1
	if cont>1:
		cont=0
	if cont<0:
		cont=1
	match cont:
		0:
			$Tentar.frame = 1
			$Sair.frame = 0
			if Input.is_action_just_pressed("ui_accept"):
				get_tree().change_scene_to_file("res://obj/world.tscn")

		1:
			$Tentar.frame = 0
			$Sair.frame = 1
			if Input.is_action_just_pressed("ui_accept"):
				get_tree().quit()
			
		
