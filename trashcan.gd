extends Node2D

var containsItem = true

@export var pickUpTimer: Timer
@export var area: Area2D
@export var trash_animation_player: AnimationPlayer
@export var trash_sprite: Sprite2D

func _ready() -> void:
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
		var tween = get_tree().create_tween().bind_node(self)
		tween.tween_property(trash_sprite, "position", Vector2(5, 0), 0.5).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(trash_sprite, "position", Vector2(0, 0), 0.52).set_trans(Tween.TRANS_BOUNCE)
	
func _on_area_2d_area_exited(_area: Area2D) -> void:
	pickUpTimer.stop()
	if containsItem:
		trash_animation_player.play("trash_with_item")
	pickUpTimer.set_wait_time(2)
	
func _on_pick_up_timeout() -> void:
	containsItem = false
	Signals.item_picked_up.emit()
	if trash_animation_player.is_playing():
		trash_animation_player.stop()
