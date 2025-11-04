extends Node2D

@onready var comp=$Button
var anum: int
var col=0
var lin=0
func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	randomize()


func _on_button_pressed() -> void:
	if Global.din>=25:
		Global.din-=25
		anum=randi_range(0,100)
		if anum<=40:
			lin=Global.comum.size()
			col=Global.comum[0].size()
			Global.comum[randi_range(0,lin-1)][col-1]=0
		elif anum <=75:
			lin=Global.incomum.size()
			col=Global.incomum[0].size()
			Global.incomum[randi_range(0,lin-1)][col-1]=0
