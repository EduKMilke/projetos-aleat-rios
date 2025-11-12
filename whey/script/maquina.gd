extends Node2D

@onready var comp=$Button
var anum: int
var col=0
var lin=0
const adddin=5
const preco=15
func _ready() -> void:
	randomize()

func _process(_delta: float) -> void:
	pass
func _on_button_pressed() -> void:
	if Global.din>=preco:
		Global.din-=preco
		anum=randi_range(0,100)
		if anum<=40:
			lin=Global.comum.size()
			col=Global.comum[0].size()
			if Global.comum[randi_range(0,lin-1)][col-1]==1:
				Global.din+=adddin
			else:
				Global.comum[randi_range(0,lin-1)][col-1]=1
		elif anum <=70:
			lin=Global.incomum.size()
			col=Global.incomum[0].size()
			if Global.incomum[randi_range(0,lin-1)][col-1]==1:
				Global.din+=adddin
			else:
				Global.incomum[randi_range(0,lin-1)][col-1]=1
		elif anum <=85:
			lin=Global.raro.size()
			col=Global.raro[0].size()
			if Global.raro[randi_range(0,lin-1)][col-1]==1:
				Global.din+=adddin
			else:
				Global.raro[randi_range(0,lin-1)][col-1]=1
		elif anum <=100:
			lin=Global.lendario.size()
			col=Global.lendario[0].size()
			if Global.lendario[randi_range(0,lin-1)][col-1]==1:
				Global.din+=adddin
			else:
				Global.lendario[randi_range(0,lin-1)][col-1]=1
