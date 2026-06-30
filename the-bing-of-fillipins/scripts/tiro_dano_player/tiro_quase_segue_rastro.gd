extends Area2D

@export var speed: float = 200.0 
var cor: Color = Color.WHITE
var player_target: Node2D = null
const PLAYER_GROUP = "player"
@onready var poca = preload("res://obj/Obstaculos/poca.tscn")
@onready var tiro_sprite = $Sprite2D
var movement_vector = Vector2.ZERO
var target_acquired = false
var a = true
var timer_poca : Timer
func _ready() -> void:
	spw_p()
	if tiro_sprite:
		tiro_sprite.modulate = cor
func _physics_process(delta):
	if not is_instance_valid(player_target):
		var players = get_tree().get_nodes_in_group(PLAYER_GROUP)
		if not players.is_empty():
			player_target = players[0]
		else:
			return 

	if is_instance_valid(player_target) and not target_acquired:
		autodestruicao()
		var direction = (player_target.global_position - global_position).normalized()
		movement_vector = direction * speed
		target_acquired = true
		
	if target_acquired:
		if a == true:
			look_at(player_target.global_position)
			a = false
		global_position += movement_vector * delta
		if global_position.distance_to(player_target.global_position) < 10:
			Global.menos_vida()
			queue_free()

func spw_p() -> void:
	timer_poca = Timer.new()
	timer_poca.wait_time = 0.6
	timer_poca.autostart = true
	timer_poca.one_shot = false
	timer_poca.timeout.connect(_criar_poca)
	add_child(timer_poca)

func _criar_poca() -> void:
	if poca:
		var nova_poca = poca.instantiate()
		nova_poca.global_position = global_position
		var sprite_da_poca = nova_poca.get_node_or_null("Sprite2D")
		if not sprite_da_poca:
			sprite_da_poca = nova_poca.get_node_or_null("Sprite2D")
		if sprite_da_poca:
			sprite_da_poca.modulate = cor
		get_tree().current_scene.add_child(nova_poca)

func autodestruicao():
	await get_tree().create_timer(10).timeout
	queue_free()
