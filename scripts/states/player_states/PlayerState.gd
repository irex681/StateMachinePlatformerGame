class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const DOUBLE_JUMPING = "DoubleJumping"
const DOUBLE_FALLING = "DoubleFalling"
const WALL_HANGING =  "WallHanging"
const WALL_JUMPING = "WallJumping"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")


func calc_x_velocity(x_direction: float, x_acceleration: float) -> float:
	
	if x_direction == 0:
		if player.velocity.x > 0:
			x_direction = -1
		if player.velocity.x < 0:
			x_direction = 1

	var new_velocity: float = player.velocity.x + x_direction * x_acceleration
	if new_velocity > player.max_x_velocity:
		return player.max_x_velocity
	elif new_velocity < -player.max_x_velocity:
		return -player.max_x_velocity
	else:
		return new_velocity
func update_state_label():
	player.statelabel.text = self.name
