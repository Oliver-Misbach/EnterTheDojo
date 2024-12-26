extends "res://src/character/state/hurt.gd"


func _enter() -> void:
	super._enter()
	assert(character is Boss)
	
	# character.target.crouch is still the same.
	if character.last_crouch == character.crouch:
		character.crouch_repeats += 1
	else:
		character.crouch_repeats = 1
	character.last_crouch = character.crouch #character.target.crouch
	
