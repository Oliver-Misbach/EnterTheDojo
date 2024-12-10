extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			Global.state = GameState.new()
			get_tree().change_scene_to_packed(load("res://src/level/level1.tscn"))
