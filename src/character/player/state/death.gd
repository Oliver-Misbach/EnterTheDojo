extends "res://src/character/state/death.gd"


@onready var player_reset_timer: Timer = $PlayerResetTimer


func _death() -> void:
	super._death()
	
	player_reset_timer.start()


func _on_player_reset_timer_timeout() -> void:
	get_tree().reload_current_scene()
