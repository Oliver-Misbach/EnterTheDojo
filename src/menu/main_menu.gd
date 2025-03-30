extends Node


@onready var high_score: Label = %HighScore


func _ready() -> void:
	high_score.text = "High score: %d" % Global.encrypted.high_score


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			Global.change_to_level()
