extends Marker2D

var numi = 0
var item = null

func _ready() -> void:
	var numale = Global.itens.size()
	
	if numale == 0:
		print("Erro: Global.itens está vazio!")
		return
		
	numi = randi_range(0, numale - 1)
	item = Global.itens[numi][0]
	var i_item = item.instantiate()
	
	# 1. Zera a posição ANTES de adicionar na cena
	i_item.position = Vector2.ZERO
	
	# 2. AGORA sim adicionamos à cena (Isso dispara o _ready do item)
	add_child(i_item)

func _process(delta: float) -> void:
	pass
