extends "res://src/character.gd"

@export var target: Player

func _physics_process(delta: float) -> void:
	if target != null:
		var offset := target.position.x - position.x
		if abs(offset) < 33.0:
			#movement = 0.0
			punch = true
			
			# 60% chance of working across 30 frames.
			if randf() < 1.0 - pow(1.0 - 0.60, 1.0 / 30.0):
				crouch = target.crouch
		else:
			movement = signf(offset)
			punch = false
	
	super._physics_process(delta)
