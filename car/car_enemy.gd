extends Area2D

const CAR_BACK = preload("res://assets/enemy/car_back.png")
const CAR_FRONT = preload("res://assets/enemy/car_front.png")

@onready var _sprite_2d: Sprite2D = %Sprite2D

var _last_y_pos:= 0.0

func _ready() -> void:
	body_entered.connect(_on_collision)
	_last_y_pos = global_position.y
	_sprite_2d.texture = null
	
func _process(_delta: float) -> void:
	if _last_y_pos > global_position.y and _sprite_2d.texture != CAR_BACK:
		rotation = 0
		_sprite_2d.texture = CAR_BACK
	elif _last_y_pos < global_position.y and _sprite_2d.texture != CAR_FRONT:
		rotation = PI
		_sprite_2d.texture = CAR_FRONT
	
	_last_y_pos = global_position.y
	
func _on_collision(body: Node2D) -> void:
	if body is Player:
		Signals.level_failed.emit()
