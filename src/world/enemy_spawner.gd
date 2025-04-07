class_name EnemySpawner
extends Node


@export var world: World
@export var types: Array[PackedScene]
@export var spawn_distance := 300.0
@export var max_enemies := 1

@export var spawn_interval := Curve.new()


@onready var timer: Timer = %Timer


var enemies: Array[Enemy]
var boss: bool


func _on_timer_timeout() -> void:
	if world.player_at_next_level:
		return
	
	if types.is_empty():
		return
	
	timer.start(spawn_interval.sample(randf()))
	
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
	enemy.world = world
	enemy.target = world.player
	enemy.position = world.player.position + Vector2.RIGHT * spawn_distance
	add_child(enemy)
	
	enemies.push_back(enemy)
	enemy.death.connect(_on_enemy_death.bind(enemy))


func _on_enemy_death(enemy: Enemy) -> void:
	enemies.erase(enemy)
	
	if enemy is Boss:
		world.player_at_next_level = true
	
	world.try_complete_level()
