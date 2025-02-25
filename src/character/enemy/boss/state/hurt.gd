extends "res://src/character/state/hurt.gd"


var _last_crouch: bool


func _enter() -> void:
	super._enter()
	
	if _last_crouch != character.crouch:
		# Player changed their crouching.
		character.crouch_repeats = 0
	
	character.crouch_repeats += 1
	_last_crouch = character.crouch
