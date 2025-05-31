extends Area2D

@export var timer: Timer

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	timer.timeout.connect(_on_timeout)

func _on_area_entered(_area: Area2D) -> void:
	timer.start()
	
func _on_timeout():
	Signals.level_completed.emit()
