extends Marker2D

var numi = 0
var item = null

func _ready() -> void:
	var numale = Global.itens.size()
	
	if numale == 0:
		print("Erro: Global.itens está vazio!")
		return
		
	numi = randi_range(0, numale - 1)
	item = Global.itens[numi]
	var i_item = item.instantiate()
	
	
	i_item.position = Vector2.ZERO
	
	
	add_child(i_item)

func _process(_delta: float) -> void:
	pass
