extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			_on_timer_timeout()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(preload("res://src/menu/main_menu.tscn"))
