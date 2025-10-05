extends Node2D

@onready var cab = $cabeca
@onready var meio = $meio
@onready var fim = $fim

const dist := 30.0

func _process(_delta: float) -> void:

	var loc = Vector2(dist, 0).rotated(cab.rotation)
	meio.position = lerp(meio.position,cab.position + loc,0.08)
	meio.rotation = cab.rotation
	var loc2 = Vector2(dist, 0).rotated(meio.rotation)
	fim.position = lerp(fim.position,meio.position + loc2,0.08)
	fim.rotation = meio.rotation
