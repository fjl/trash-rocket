extends Node2D

var containsItem = true

@export var pickUpTimer: Timer
@export var area: Area2D
@export var trash_animation_player: AnimationPlayer
@export var trash_sprite: Sprite2D
@export var timeout: float = 0.7
@export var tween_duration: float = 0.05
@onready var timed_progress_bar: MarginContainer = %TimedProgressBar

func _ready() -> void:
	pickUpTimer.set_wait_time(timeout)
	pickUpTimer.timeout.connect(_on_pick_up_timeout)

	if trash_animation_player == null:
		printerr("trash_animation_player is not defined.")
		
	area.area_entered.connect(_on_area_2d_area_entered)
	area.area_exited.connect(_on_area_2d_area_exited)

	if containsItem:
		trash_animation_player.play("trash_with_item")
	

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if containsItem:
		if pickUpTimer.is_stopped():
			pickUpTimer.start()
			timed_progress_bar.show()
			timed_progress_bar.restart()
		
		var tween = get_tree().create_tween().bind_node(self)
		for i in range(3):
			tween.tween_property(trash_sprite, "position", Vector2(5, 0), tween_duration).set_trans(Tween.TRANS_BOUNCE)
			tween.tween_property(trash_sprite, "position", Vector2(0, 0), tween_duration).set_trans(Tween.TRANS_BOUNCE)
	
func _on_area_2d_area_exited(_area: Area2D) -> void:
	pickUpTimer.stop()
	timed_progress_bar.hide()
	timed_progress_bar.stop()
	
	#if containsItem:
		#trash_animation_player.play("trash_with_item")
	pickUpTimer.set_wait_time(timeout)
	
func _on_pick_up_timeout() -> void:
	containsItem = false
	timed_progress_bar.hide()
	Signals.item_picked_up.emit()
	if trash_animation_player.is_playing():
		trash_animation_player.stop()
