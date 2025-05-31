extends CharacterBody2D

@export var player_speed = 100

func _process(delta):
	var direction = Vector2(
   	 Input.get_action_strength("right") - Input.get_action_strength("left"),
   	 Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	direction = direction.normalized()
	velocity = direction * player_speed
	move_and_slide()
