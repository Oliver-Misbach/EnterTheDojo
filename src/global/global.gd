extends Node


@export var levels: Array[PackedScene]


var encrypted := Encrypted.new()

# Sent between scenes.
var health_bonus: int
var speed_bonus: int


func _enter_tree() -> void:
	load_enc()


func _exit_tree() -> void:
	save_enc()


#func _ready() -> void:
	#Engine.time_scale = 0.2


func load_enc() -> void:
	var data := SaveLoad.load_enc()
	print_debug("global: load: %s" % data)
	encrypted.read(data)


func save_enc() -> void:
	var data := encrypted.write()
	print_debug("global: save: %s" % data)
	SaveLoad.save_enc(data)


func change_to_level() -> void:
	print_debug("global: level: %d" % encrypted.state.level)
	if encrypted.state.level >= levels.size():
		get_tree().change_scene_to_packed(preload("res://src/menu/finish_menu.tscn"))
	else:
		get_tree().change_scene_to_packed(levels[encrypted.state.level])


func finalize_game() -> void:
	encrypted.high_score = maxi(encrypted.high_score, encrypted.state.score)
	encrypted.state = GameState.new()
	save_enc()


func ok(status: int, message := "error") -> void:
	assert(status == OK, "%s: %d" % [message, status])
