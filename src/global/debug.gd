extends Node


@export var time_scale := 1.0


func _ready() -> void:
	if not OS.is_debug_build():
		return
	
	Engine.time_scale = time_scale


func _input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed(&"debug_reload"):
		get_tree().reload_current_scene()
	if event.is_action_pressed(&"debug_pause_resume"):
		get_tree().paused = not get_tree().paused
