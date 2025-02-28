class_name StateMachine
extends Node


@export var current: State:
	set(state):
		if not is_node_ready():
			# Only switch states when all children are initialized.
			await ready
		
		if current != null:
			current.state_changed.disconnect(_set_state)
			current.is_active = false
			current._exit()
		current = state
		Global.ok(state.state_changed.connect(_set_state))
		state.is_active = true
		state._enter()


func _process(delta: float) -> void:
	current._process_frame(delta)


func _physics_process(delta: float) -> void:
	current._physics_frame(delta)


func _set_state(state: State) -> void:
	current = state
