extends Node

@export var current: State:
	set(state):
		if is_inside_tree():
			assert(current != null)
			current.state_changed.disconnect(set.bind(&"current"))
			current._exit()
		current = state
		Global.ok(state.state_changed.connect(set.bind(&"current")))
		state._enter()

func _physics_process(delta: float) -> void:
	current._physics_update(delta)
