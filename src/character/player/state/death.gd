extends "res://src/character/state/death.gd"


func _exit() -> void:
	super._exit()
	get_tree().reload_current_scene()
