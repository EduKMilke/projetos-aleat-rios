extends StaticBody2D
@onready var spr=$Sprite2D
@onready var colis=$CollisionShape2D
@onready var area=$Area2D/CollisionShape2D
@onready var scale_spr=spr.scale
func _ready() -> void:
	spr.modulate="#00ffff"

func _process(_delta: float) -> void:

	if Global.inverte==1:
		if Input.is_action_just_pressed("ui_accept"):
			spr.scale=spr.scale/2
		area.disabled=false
		colis.disabled=false
		spr.modulate="#00ffff"
		
	else:
		area.disabled=true
		colis.disabled=true
		spr.modulate="#00ffff45"
	spr.scale=lerp(spr.scale,scale_spr,0.1)
func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body is CharacterBody2D:  
		body.morte()
