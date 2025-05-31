extends Control

signal complete

@export_range(0.1, 10.0, 0.1) var fill_time_seconds:= 2.0
@export var running:= true
@export var text:= "searching..."

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var label: Label = %Label

func _ready() -> void:
	label.text = text

func restart() -> void:
	progress_bar.value = 0.0
	running = true

func stop() -> void:
	running = false

func _process(delta: float) -> void:
	if running:
		progress_bar.value += delta / fill_time_seconds * 100
		
		if progress_bar.value == progress_bar.max_value:
			running = false
			complete.emit()
