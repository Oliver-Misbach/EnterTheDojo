class_name Player
extends Character


var left: float
var right: float


func _physics_process(delta: float) -> void:
	movement = right - left
	
	super._physics_process(delta)
