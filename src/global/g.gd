extends Node


func ok(status: int, message := "error") -> void:
	assert(status == OK, "%s: %d" % [message, status])
