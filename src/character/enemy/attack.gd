extends "res://src/character/state/attack.gd"


func _exit() -> void:
	super._exit()
	
	character.punch = false
	character.kick = false
