extends Area2D

var vida = 10
var player = null
@export var posca_scene: PackedScene = preload("res://obj/inimigos/Inimigos de cola/RastroCola.tscn")
@onready var timer =$Timer
@export var largura_sala:float = 1000
@export var altura_sala:float = 550
var gerando = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if vida <=0:
		queue_free()
		return
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	if global_position.distance_to(player.global_position) < 800:
		if not gerando:
			gerando = true
			timer.start(1)
	else:
		if gerando:
			gerando = false
			timer.stop()

func _on_timer_timeout() -> void:
	if player == null: return
	var nova_cola = posca_scene.instantiate()
	
	var centro_da_sala = get_parent().global_position
	var limite_x = largura_sala / 2.0
	var limite_y = altura_sala / 2.0
	
	var offset = Vector2(
		randf_range(-200.0, 200.0),
		randf_range(-200.0, 200.0)  
	)
	nova_cola.global_position = global_position + offset
	#var offsetsala = Vector2(
		#randf_range(-limite_x, limite_x),
		#randf_range(-limite_y, limite_y)
	#)
	#nova_cola.global_position = centro_da_sala + offsetsala #Isso ta comentado pq eu tentei fazer spawnar em qualquer lugar da sala, mas n funfo direito, pq spawna fora
	get_tree().current_scene.add_child(nova_cola)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
