extends "res://src/character/state/death.gd"


#func _death() -> void:
	#super._death()


func _enter() -> void:
	super._enter()
	
	# Now handled in character.gd
	#character.death.emit()
	
	character.collision_layer = 0
	character.collision_mask = 0
	
	#character.process_mode = Node.PROCESS_MODE_DISABLED
