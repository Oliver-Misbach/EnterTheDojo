class_name StateMachine
extends Node


@export var current: State:
	set(state):
		if is_inside_tree():
			assert(current != null)
			current.state_changed.disconnect(_set_state)
			current._exit()
		current = state
		Global.ok(state.state_changed.connect(_set_state))
		state._enter()


func _physics_process(delta: float) -> void:
	current._physics_update(delta)


func _set_state(state: State) -> void:
	current = state
