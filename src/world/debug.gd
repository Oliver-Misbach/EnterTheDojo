extends Node


@export var world: World


func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed(&"debug_reload"):
		get_tree().reload_current_scene()
	if event.is_action_pressed(&"debug_pause_resume"):
		get_tree().paused = not get_tree().paused
	if event.is_action_pressed(&"debug_next_level"):
		world.complete_level()
	if event.is_action_pressed(&"debug_kill_all"):
		for enemy in world.enemy_spawner.enemies:
			enemy.kill()
