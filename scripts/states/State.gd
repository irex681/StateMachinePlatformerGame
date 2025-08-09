class_name State extends Node

# This class is meant to be overidden by states that encapsulate the desired behavior. It abstracts methods and signals that will be implemented in a more specific fashion down the line. 

#Signal to move from one state to the next
signal finished()

#same as physics process - however this is called by the state machine.
func physics_update(_delta: float) -> void:
	pass 

#called when a state begins, essentially a ready() for the state.
func enter() -> void:
	pass
