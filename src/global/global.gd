extends Node


@export var levels: Array[PackedScene]


var state := GameState.new()
var current_level: int # TODO: Could be saved.
var health_bonus: int
var speed_bonus: int


#func _ready() -> void:
	#Engine.time_scale = 0.2


func ok(err: int) -> void:
	assert(err == OK, "Error: %d" % err)


func change_level() -> void:
	#print("Level: ", Global.current_level)
	get_tree().change_scene_to_packed(Global.levels[Global.current_level])
