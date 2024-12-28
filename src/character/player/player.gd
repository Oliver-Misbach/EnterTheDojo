class_name Player
extends "res://src/character/character.gd"

var left: float
var right: float

func _physics_process(delta: float) -> void:
	movement = right - left
	
	super._physics_process(delta)

func damage() -> void:
	super.damage()
