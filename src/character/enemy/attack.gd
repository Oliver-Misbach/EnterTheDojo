extends "res://src/character/state/attack.gd"

func _enter() -> void:
	super._enter()
	character.enemy_attack_timer.start()

func _exit() -> void:
	super._exit()
	character.punch = false
	character.kick = false
