@tool
class_name HomeRolledGif extends Control

@export var frames: Array[Texture2D] = []
@export var fps:= 1.0
@export var loop:= false
@export_tool_button("restart") var restart_action = set.bind("_progress", 0.0)
#@export var scale:= 1.0

@onready var texture_rect: TextureRect = %TextureRect

var _progress:= 0.0

func _process(delta: float) -> void:
	_progress += delta
	
	var frame:= roundf(_progress * fps)
	
	texture_rect.texture = frames[min(frame, frames.size() - 1)]
	
	if frame >= frames.size() and loop:
		_progress = 0
	
	
