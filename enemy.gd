extends CharacterBody2D

signal player_seen

@export var field_of_vision:Area2D
@export var obstacle_check_ray:RayCast2D


var player_in_field:bool = false
var player_area:Area2D


func _ready() -> void:
	field_of_vision.area_entered.connect( _on_area_2d_player_entered )
	field_of_vision.area_exited.connect( _on_area_2d_player_exited )
	
	
func _physics_process(_delta: float) -> void:
	if player_in_field:
		modulate = Color.ORANGE
		obstacle_check_ray.look_at( player_area.global_position )
		obstacle_check_ray.force_raycast_update()
		if obstacle_check_ray.is_colliding():
			if obstacle_check_ray.get_collider().is_in_group('Player'):
				player_seen.emit()
				modulate = Color.ORANGE_RED
	else:
		modulate = Color.WHITE
		

func _on_area_2d_player_entered( area: Area2D ) -> void:
	player_area = area
	player_in_field = true

func _on_area_2d_player_exited( area: Area2D ) -> void:
	player_in_field = false
