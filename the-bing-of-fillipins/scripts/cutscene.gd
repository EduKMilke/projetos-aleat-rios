extends Node2D
var etapa = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Cen.frame +=1
	etapa+=1
	if etapa == 3:
		$Label.visible = true
	if etapa == 4:
		$Label.visible = false
		$Preto/AnimationPlayer.play("Escrueeee")
		await $Preto/AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://obj/world.tscn")


func _on_pular_pressed() -> void:
	$Preto/AnimationPlayer.play("Escrueeee")
	await $Preto/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://obj/world.tscn")
