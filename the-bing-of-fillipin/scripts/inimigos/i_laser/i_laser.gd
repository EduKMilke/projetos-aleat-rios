extends StaticBody2D

var player=null
var laser=preload("res://obj/inimigos/laser.tscn")
var a=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
	if player != null and global_position.distance_to(player.global_position) < 800:
		if a==true:
			await get_tree().create_timer(1).timeout
			var i_laser=laser.instantiate()
			add_child(i_laser)
			a=false
