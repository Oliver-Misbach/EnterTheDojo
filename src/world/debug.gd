extends Node


func _unhandled_input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed(&"debug_pause"):
			get_tree().paused = true
		if event.is_action_pressed(&"debug_resume"):
			get_tree().paused = false
		if event.is_action_pressed(&"debug_reload"):
			get_tree().reload_current_scene()
