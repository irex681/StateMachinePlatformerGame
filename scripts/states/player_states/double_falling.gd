extends PlayerState

func enter() -> void:
	update_state_label()
	pass

func physics_update(delta: float) -> void:
	var xdir = Input.get_axis("left","right")
	player.velocity.x = calc_x_velocity(xdir,player.falling_x_acceleration)
	player.velocity.y = min(player.velocity.y+ player.gravity * delta,player.max_y_velocity)
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(xdir, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	if player.is_on_wall():
		finished.emit(WALL_HANGING)
