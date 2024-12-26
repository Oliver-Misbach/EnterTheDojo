class_name State
extends Node


@warning_ignore("UNUSED_SIGNAL")
signal state_changed(state: State)


var is_active: bool


func _enter() -> void:
	pass


func _exit() -> void:
	pass


func _idle_update(_delta: float) -> void:
	pass


func _physics_update(_delta: float) -> void:
	pass
