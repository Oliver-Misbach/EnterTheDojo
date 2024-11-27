extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			Global.state = State.new()
			get_viewport().set_input_as_handled()
			get_tree().change_scene_to_packed(load("res://src/level/level1.tscn"))
