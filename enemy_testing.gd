extends Node2D
@onready var player: Sprite2D = $Player

func _process(_delta: float) -> void:
	player.global_position = get_global_mouse_position()
