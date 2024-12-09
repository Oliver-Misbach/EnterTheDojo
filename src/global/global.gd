extends Node


var state := State.new()
var next_scene: PackedScene
var health_bonus: int
var speed_bonus: int


func ok(err: int) -> void:
	assert(err == OK, "Error: %d" % err)
