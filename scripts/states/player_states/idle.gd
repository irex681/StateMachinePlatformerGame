extends PlayerState

func enter() -> void:
	update_state_label()
	player.velocity.x = 0.0
	
func physics_update(delta: float) -> void:
	player.velocity.y = min(player.velocity.y+ player.gravity * delta,player.max_y_velocity)
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(RUNNING)
