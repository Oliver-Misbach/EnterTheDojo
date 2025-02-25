extends "res://src/character/state/death.gd"


func _death() -> void:
	super._death()
	
	character.death.emit()
	character.process_mode = Node.PROCESS_MODE_DISABLED
