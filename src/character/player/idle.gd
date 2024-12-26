extends "res://src/character/state/idle.gd"


var crouch: bool


func _enter() -> void:
	_update_input()
	super._enter()
	
	if character.is_queued_for_deletion():
		get_tree().reload_current_scene()


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
		crouch = event.is_pressed()


func _physics_update(delta: float) -> void:
	_update_input()
	super._physics_update(delta)


func _update_input() -> void:
	#print(character.crouch, " = ", crouch)
	character.crouch = crouch
