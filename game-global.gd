extends Node

func _ready() -> void:
	Signals.level_completed.connect(_on_level_completed)	
	Signals.level_failed.connect(_on_level_failed)

func _on_level_completed(nextLevel):
	if not nextLevel:
		nextLevel = "res://end_scene_success.tscn"
	get_tree().change_scene_to_file(nextLevel)
	pass
	
func _on_level_failed():
	print("level failed")
	get_tree().change_scene_to_file("res://end_scene_fail.tscn")
	pass
	
func restart()->void:
	get_tree().change_scene_to_file("res://main.tscn")
