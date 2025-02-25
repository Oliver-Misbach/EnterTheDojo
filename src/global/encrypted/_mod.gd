class_name Encrypted
extends Resource


@export var state := GameState.new()
@export var high_score: int


func read(dict: Dictionary) -> void:
	high_score = dict.get(&"high_score", 0)
	state.read(dict.get(&"state", {}))


func write() -> Dictionary:
	return {
		&"high_score": high_score,
		&"state": state.write(),
	}
