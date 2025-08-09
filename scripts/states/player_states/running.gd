extends PlayerState

var cayote_time: float = 0.03
var cayote_time_started: bool

func enter() -> void:
	update_state_label()
	cayote_time_started = false
	pass

func physics_update(delta: float) -> void:
	var xdir = Input.get_axis("left","right")
	
	player.velocity.x = calc_x_velocity(xdir,player.walking_x_acceleration)
	player.move_and_slide()
	
	var was_on_floor: bool = player.is_on_floor()

	if not player.is_on_floor() and not cayote_time_started:
		cayote_time_started = true
		get_tree().create_timer(cayote_time).timeout.connect(on_cayote_time_timeout)
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	if is_equal_approx(xdir, 0.0):
		finished.emit(IDLE)

func on_cayote_time_timeout() -> void:
	finished.emit(FALLING)
