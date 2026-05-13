extends StaticBody2D
var vida=3
func _process(delta: float) -> void:
	if vida==3:
		$PilhaDeLivros.frame = 0
	if vida==2:
		$PilhaDeLivros.frame = 1
	if vida==1:
		$PilhaDeLivros.frame = 2
	if vida<=0:
		queue_free()
