class_name StateMachine extends Node

#The initial state of the machine
@export var start_state: State = null

#The current state of the machine
var state: State


func _ready() -> void:
	#initial state of the machine must be set in the export
	state = start_state 
	assert(start_state != null, "Need to assign initial state somewhere")
	
	#Goes through all states, and connects transitions to all states on the state machine
	for childStates: State in get_children():
		#connects the finished signal to the transition by just passing the path of the next string
		childStates.finished.connect(transition)
	
	#making sure the player is initialized so that the state can use player functions
	await owner.ready


#Taking in the physics process function and passing it onto the state
func _physics_process(delta: float) -> void:
	state.physics_update(delta)

# Goes to the next node specified by the string 
func transition(next_state: String) -> void:
	if not has_node(next_state):
		printerr( next_state + " DOES NOT EXIST ")
		return

	state = get_node(next_state)
	state.enter()
