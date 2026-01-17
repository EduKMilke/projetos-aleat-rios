extends Node2D
@onready var player=$CharacterBody2D
func _process(_delta: float) -> void:
	if is_instance_valid(player) and player.morto==false:
		if Input.is_action_just_pressed("ui_accept"):
			scale.y *= -1
			Global.inverte *= -1
