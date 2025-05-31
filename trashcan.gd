extends Node2D

var containsItem = true

@export var area: Area2D

func _ready() -> void:
	area.area_entered.connect(_on_area_2d_area_entered)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if containsItem:
		Signals.item_picked_up.emit()	
	containsItem = false
