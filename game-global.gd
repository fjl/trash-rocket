extends Node

func _ready() -> void:
	Signals.level_completed.connect(_on_level_completed)	
	Signals.level_failed.connect(_on_level_failed)

func _on_level_completed():
	get_tree().change_scene_to_file("res://end_scene_success.tscn")
	pass
	
func _on_level_failed():
	print("level failed")
	get_tree().change_scene_to_file("res://end_scene_fail.tscn")
	pass
