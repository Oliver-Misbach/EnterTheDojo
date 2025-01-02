extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			Global.state = GameState.new()
			Global.current_level = 0
			Global.change_level()
