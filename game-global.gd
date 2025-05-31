extends Node

func _ready() -> void:
	Signals.level_objective_reached.connect(_on_level_objective_reached)	
	Signals.level_failed.connect(_on_level_failed)

func _on_level_objective_reached():
	get_tree().change_scene_to_file("res://end_scene_success.tscn")
	pass
	
func _on_level_failed():
	get_tree().change_scene_to_file("res://end_scene_success.tscn")
	pass
