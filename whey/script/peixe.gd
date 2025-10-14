extends Node2D

@onready var cab = $cabeca
@onready var meio = $meio
@onready var fim = $fim

const dist := 10.0
const desloc = 0.35

func _process(_delta: float) -> void:

	var loc = Vector2(dist, 0).rotated(cab.rotation)
	meio.position = lerp(meio.position,cab.position + loc,desloc)
	meio.rotation = lerp_angle(meio.rotation,cab.rotation,0.5)

	var loc2 = Vector2(dist, 0).rotated(meio.rotation)
	fim.position = lerp(fim.position,meio.position + loc2,desloc*1.2)
	fim.rotation = lerp_angle(fim.rotation,meio.rotation,0.5)
