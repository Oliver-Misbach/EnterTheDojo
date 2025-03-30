extends Node


@onready var score: Label = %Score
@onready var high_score: Label = %HighScore


func _ready() -> void:
	score.text = "Score: %d" % Global.encrypted.state.score
	high_score.text = "High Score: %d" % Global.encrypted.state.score


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			finalize_game()


func finalize_game() -> void:
	Global.finalize_game()
	get_tree().change_scene_to_packed(preload("res://src/menu/main_menu.tscn"))
