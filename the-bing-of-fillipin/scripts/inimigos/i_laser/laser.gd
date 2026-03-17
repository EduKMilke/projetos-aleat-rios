extends RayCast2D

@export var color := Color.CYAN: set = set_color
@export var beam_width := 4.0
@export var max_length := 2000.0
var player= null

# Tente usar o $Line2D se o % não estiver funcionando
@onready var line_2d: Line2D = get_node_or_null("Line2D")

func _ready() -> void:
	if line_2d == null:
		push_error("ERRO: O nó Line2D não foi encontrado! Verifique o nome na árvore de cena.")
		return
		
	line_2d.points = [Vector2.ZERO, Vector2.ZERO]
	line_2d.width = beam_width
	set_color(color)
	target_position = Vector2(max_length, 0)
	await get_tree().create_timer(1).timeout
	queue_free()
func _physics_process(_delta: float) -> void:
	if line_2d == null: return
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	look_at(player.global_position)
	var cast_point := target_position
	force_raycast_update()
	if is_colliding():
		cast_point = to_local(get_collision_point())
	line_2d.set_point_position(1, cast_point)

func set_color(new_color: Color) -> void:
	color = new_color
	if line_2d:
		line_2d.default_color = new_color
