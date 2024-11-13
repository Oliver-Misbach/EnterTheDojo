class_name Player
extends "res://src/character.gd"

var left: float
var right: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(&"left"):
		left = event.get_action_strength(&"left")
	if event.is_action(&"right"):
		right = event.get_action_strength(&"right")
	if event.is_action(&"punch"):
		punch = event.is_pressed()
	if event.is_action(&"kick"):
		kick = event.is_pressed()
	if event.is_action(&"jump"):
		jump = event.is_pressed()
	if event.is_action(&"crouch"):
		crouch = event.is_pressed()

func _physics_process(delta: float) -> void:
	movement = right - left
	
	super._physics_process(delta)

func damage() -> void:
	super.damage()
	
	if is_queued_for_deletion():
		get_tree().reload_current_scene()
