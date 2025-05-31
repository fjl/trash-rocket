extends Control

@export var rocket: ProgressBar
@export var goalItems: int

var items = 0

func _ready() -> void:
	rocket.max_value = goalItems
	Signals.item_picked_up.connect(_on_item_pickedUp)

func _on_item_pickedUp():
	items = items + 1
	rocket.value = items
	if items >= goalItems:
		print("you are done")
