extends Node2D

@onready var _path_follower: PathFollower = %PathFollower
@onready var _continue_button: Button = %ContinueButton

func _ready() -> void:
	_path_follower.point_reached.connect(_continue_button.set.bind("disabled", false))
	_continue_button.pressed.connect(_on_continue_pressed)

func _on_continue_pressed() -> void:
	_continue_button.disabled = true
	_path_follower.running = true
