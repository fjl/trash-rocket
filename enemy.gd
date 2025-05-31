extends CharacterBody2D

@export var static_guarding:bool
@export var spinning_speed:float

@export var field_of_vision:Area2D
@export var obstacle_check_ray:RayCast2D
@export var failTimer: Timer
@export var character: Sprite2D



var player_in_field:bool = false
var player_is_seen:bool = false
var player_area:Area2D

func _ready() -> void:
	field_of_vision.area_entered.connect( _on_area_2d_player_entered )
	field_of_vision.area_exited.connect( _on_area_2d_player_exited )
	failTimer.timeout.connect(_on_fail_timer_timeout)
	
func _physics_process( delta: float) -> void:
	#--- spinning -----
	if static_guarding:
		field_of_vision.rotate( spinning_speed * delta ) 
	#--- update visuals -----
	character.global_rotation = 0.0
	character.global_position = global_position + Vector2(0,-17)
	field_of_vision.global_position = global_position + Vector2(0,-33)
	
	#--- detection ------
	if player_in_field:
		modulate = Color.ORANGE
		obstacle_check_ray.look_at( player_area.global_position )
		obstacle_check_ray.force_raycast_update()
		if obstacle_check_ray.is_colliding():
			if obstacle_check_ray.get_collider().is_in_group('Player'):
				if not player_is_seen:
					failTimer.start()
				player_is_seen = true
				modulate = Color.ORANGE_RED
	else:
		modulate = Color.WHITE
		failTimer.stop()
		player_is_seen = false

func _on_area_2d_player_entered( area: Area2D ) -> void:
	player_area = area
	player_in_field = true

func _on_area_2d_player_exited( area: Area2D ) -> void:
	player_in_field = false

func _on_fail_timer_timeout() -> void:
	Signals.level_failed.emit()
