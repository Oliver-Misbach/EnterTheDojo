class_name GameState
extends Resource


@export var level: int
@export var score: int


func read(dict: Dictionary) -> void:
	level = dict.get(&"level", 0)
	score = dict.get(&"score", 0)


func write() -> Dictionary:
	return {
		&"level": level,
		&"score": score,
	}
