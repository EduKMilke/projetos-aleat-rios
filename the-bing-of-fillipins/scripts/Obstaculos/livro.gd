extends StaticBody2D
var vida=3
var diario_scene = preload("res://obj/Obstaculos/Diario.tscn")
func _process(delta: float) -> void:
	if vida==3:
		$PilhaDeLivros.frame = 0
	if vida==2:
		$PilhaDeLivros.frame = 1
	if vida==1:
		$PilhaDeLivros.frame = 2
	if vida<=0:
		destruir()

func destruir():
	var chanced = randf()
	if chanced <= 0.1:
		spawnar_diario()
	queue_free()
	
func spawnar_diario():
	var novo_diario = diario_scene.instantiate()
	
	get_parent().add_child(novo_diario)
	novo_diario.global_position = global_position
	print ("Tu é mais cagado que Eduardo em dia de banho sagrado")
