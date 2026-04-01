extends RayCast2D

@export var max_length := 2000.0
@onready var line_2d: Line2D = get_node_or_null("Line2D")
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	enabled = true
	# Define o alcance máximo do laser para a direita (X)
	target_position = Vector2(max_length, 0)
	
	if line_2d:
		line_2d.points = [Vector2.ZERO, Vector2.ZERO]


func configurar_alvo(pos_alvo: Vector2) -> void:
	# Gira o RayCast para apontar para o Boss
	look_at(pos_alvo)
	force_raycast_update()

func _physics_process(_delta: float) -> void:
	var cast_point := target_position
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
		# Opcional: Se o laser bater em algo que tem vida, causa dano
		var obj = get_collider()
		if obj.has_method("receber_dano"):
			obj.receber_dano(1)

	# Atualiza a linha visual
	if line_2d:
		line_2d.set_point_position(0, Vector2.ZERO)
		line_2d.set_point_position(1, cast_point)
	
	# Atualiza a área de colisão (Area2D)
	if collision_shape and collision_shape.shape is SegmentShape2D:
		collision_shape.shape.b = cast_point
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.menos_vida()
