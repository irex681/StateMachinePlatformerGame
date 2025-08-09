extends PlayerState

func enter() -> void:
	update_state_label()
	player.velocity.y = -player.jump_speed

func physics_update(delta: float) -> void:
	var xdir = Input.get_axis("left","right")
	player.velocity.x = calc_x_velocity(xdir,player.walking_x_acceleration)
	player.velocity.y = min(player.velocity.y+ player.gravity * delta,player.max_y_velocity)
	player.move_and_slide()

	if Input.is_action_just_pressed("jump"):
		finished.emit(DOUBLE_JUMPING)
	elif player.velocity.y >= 0:
		finished.emit(FALLING)
