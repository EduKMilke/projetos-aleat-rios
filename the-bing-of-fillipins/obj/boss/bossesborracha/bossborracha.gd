extends Node2D
var player=null
var b=true
@onready var b1=$b1
@onready var b2=$b2
@onready var alca = preload("res://scripts/boss/alcpao.tscn")
var barra_vida = preload("res://obj/boss/barra_vida_boss.tscn")
var _ibar_vida
var _progress_bar
var vida = 70 * Global.inteligencia
var speed=125
var dire=0;
var b2_direction = Vector2.RIGHT
func _ready() -> void:
	_ibar_vida = barra_vida.instantiate()
	_progress_bar = _ibar_vida.get_node("CanvasLayer/ProgressBar")
	_progress_bar.max_value = vida
	_progress_bar.value = vida

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		
	if player != null and global_position.distance_to(player.global_position) < 800:
		if b == true:
			get_tree().current_scene.add_child(_ibar_vida)
			b = false

		dire = b1.global_position.direction_to(player.global_position)
		b1.velocity = dire * speed
		b1.move_and_slide()
		
		var collision = b2.move_and_collide(b2_direction * speed * delta)
		if collision:
			
			b2_direction = b2_direction.bounce(collision.get_normal())

func tomar_dano(quantidade: int) -> void:
	vida -= quantidade
	
	if _progress_bar:
		_progress_bar.value = vida
		
	if vida <= 0:
		morrer()

func morrer() -> void:

	if is_instance_valid(_ibar_vida):
		_ibar_vida.queue_free()
		var i_alca = alca.instantiate()
		var pos_morte = global_position 
		get_tree().current_scene.add_child(i_alca)
		i_alca.global_position = pos_morte
	queue_free()
