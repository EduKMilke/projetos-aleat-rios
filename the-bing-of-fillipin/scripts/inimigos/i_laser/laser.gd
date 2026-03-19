extends RayCast2D

@export var color := Color.CYAN: set = set_color
@export var beam_width := 4.0
@export var max_length := 2000.0

@onready var line_2d: Line2D = get_node_or_null("Line2D")
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	if line_2d == null: return
	
	line_2d.points = [Vector2.ZERO, Vector2.ZERO]
	line_2d.width = beam_width
	set_color(color)
	
	target_position = Vector2(max_length, 0)
	
	await get_tree().create_timer(1.0).timeout
	queue_free()

func configurar_alvo(pos_alvo: Vector2) -> void:
	look_at(pos_alvo)

func _physics_process(_delta: float) -> void:
	if line_2d == null: return
	
	force_raycast_update()
	
	var cast_point := target_position
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	
	line_2d.set_point_position(1, cast_point)
	atualizar_colisao_area(cast_point)

func atualizar_colisao_area(ponto_final: Vector2) -> void:
	if collision_shape.shape is SegmentShape2D:
		collision_shape.shape.a = Vector2.ZERO
		collision_shape.shape.b = ponto_final
	elif collision_shape.shape is RectangleShape2D:
		var length = ponto_final.length()
		collision_shape.shape.size = Vector2(length, beam_width)
		collision_shape.position = Vector2(length / 2, 0)

func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d:
		line_2d.default_color = new_color

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
