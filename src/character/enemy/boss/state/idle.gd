extends "res://src/character/state/idle.gd"


func _enter() -> void:
	assert(character is Boss)
	character.next_combo_move()
	super._enter()
