extends Control

@export var rocket: ProgressBar
@export var exitSign: Area2D
@export var goalItems: int

var items: int = 0

func _ready() -> void:
	Signals.item_picked_up.connect(_on_item_pickedUp)
	rocket.max_value = goalItems
	disableExit()

func _on_item_pickedUp():
	items = items + 1
	rocket.value = items
	if items >= goalItems:
		enableExit()
		
func disableExit():
	exitSign.visible = false
	exitSign.monitoring = false
	
func enableExit():
	exitSign.visible = true
	exitSign.monitoring = true
