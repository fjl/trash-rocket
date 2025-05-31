class_name PathFollower extends PathFollow2D

signal point_reached()

@export var speed:= 10
@export var running:= true
@export var point_reached_range:= 10.0
@export var pause_when_node_reached:= true
@export var show_debug:= false

var _child_to_move: Node2D
var _next_point:= 1
var _path: Path2D

func _ready() -> void:
	_path = (get_parent() as Path2D)
	_child_to_move = get_child(0)

func _get_configuration_warning():
	if get_child_count() != 1 or get_child(0) is not Node2D:
		return ["Must contain exactly 1 child that extends Node2D"]
	return []

func _process(delta: float) -> void:
	queue_redraw()

	if not running:
		return
	
	var _move_distance:= delta * speed
	progress += _move_distance
	
	_has_reached_next_node()

func _has_reached_next_node() -> void:
	var node_position: Vector2 = _path.to_global(_path.curve.get_point_position(0))
	var distance_to_next_point:= _child_to_move.position.distance_to(_node_point_local_position(_next_point))

	if distance_to_next_point < point_reached_range:
		_next_point = _next_point + 1 if _path.curve.point_count > _next_point + 1 else 1
		
		if _next_point == 1:
			progress = 0
		
		point_reached.emit()
		
		if pause_when_node_reached:
			running = false

func _node_point_local_position(point_idx: int) -> Vector2:
	return to_local(_path.to_global(_path.curve.get_point_position(point_idx)))

func _draw() -> void:
	if !show_debug:
		return

	for idx in range(_path.curve.point_count):
		var end_point:= _child_to_move.to_local(_path.to_global(_path.curve.get_point_position(idx)))
		draw_line(_child_to_move.position, end_point, Color.RED)
		draw_string(ThemeDB.fallback_font, end_point, str(idx))
