extends Node


@export var world: World
@export var types: Array[PackedScene]
@export var spawn_distance := 300.0
@export var max_enemies := 1


@onready var timer: Timer = $Timer


var enemies: Array[Enemy]
var boss: bool


func _on_timer_timeout() -> void:
	if types.is_empty():
		return
	
	timer.start(randf_range(1.0, 3.0))
	
	if enemies.size() >= max_enemies:
		return
	
	# Hacky boss spawner.
	if boss:
		return
	else:
		if world.scene_file_path == "res://src/level/debug_boss_only.tscn":
			boss = true
		if world.scene_file_path == "res://src/level/level3.tscn" and \
				world.player.position.x >= 2000.0 - spawn_distance - 820.0:
			boss = true
	if boss:
		types = [
			preload("res://src/character/enemy/boss/boss.tscn"),
		]
	
	var enemy: Enemy = types.pick_random().instantiate()
	enemy.target = world.player
	enemy.position = world.player.position + Vector2.RIGHT * spawn_distance
	add_child(enemy)
	
	enemies.push_back(enemy)
	enemy.death.connect(enemies.erase.bind(enemy))
