extends PlayerState



func enter() -> void:
	update_state_label()
	player.velocity.y = 0
	pass

func physics_update(delta: float) -> void:
	var xdir = Input.get_axis("left","right")
	player.velocity.x = calc_x_velocity(xdir, player.walking_x_acceleration)
	player.move_and_slide()
	if is_sliding_on_wall():
		player.velocity.y = min(player.velocity.y+ player.gravity/6 * delta,player.max_y_velocity)
	else:
		player.velocity.y = min(player.velocity.y+ player.gravity * delta,player.max_y_velocity)
		#if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		player.position.x += player.get_wall_normal().x
		finished.emit(DOUBLE_FALLING)
		
	if Input.is_action_pressed("jump"):
		finished.emit(WALL_JUMPING)
	
	elif player.is_on_floor():
		if is_equal_approx(xdir, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
		
			
func is_sliding_on_wall() -> bool:
	if player.is_on_wall():
		if player.get_wall_normal().x > 0:
			if Input.is_action_pressed("left"):
				return true
		if player.get_wall_normal().x < 0:
			if Input.is_action_pressed("right"):
				return true
	return false
