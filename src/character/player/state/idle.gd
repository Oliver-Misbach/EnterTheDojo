extends "res://src/character/state/idle.gd"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event.is_action(&"left"):
		character.left = event.get_action_strength(&"left")
	if event.is_action(&"right"):
		character.right = event.get_action_strength(&"right")
	if event.is_action(&"punch"):
		character.punch = event.is_pressed()
	if event.is_action(&"kick"):
		character.kick = event.is_pressed()
	#if event.is_action(&"jump"):
		#jump = event.is_pressed()
	if event.is_action(&"crouch"):
		character.crouch = event.is_pressed()
