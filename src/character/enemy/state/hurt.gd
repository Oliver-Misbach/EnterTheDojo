extends "res://src/character/state/hurt.gd"


func _enter() -> void:
	super._enter()
	
	character.last_hurt_style = [punch, crouch]
