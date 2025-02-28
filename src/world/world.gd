class_name World
extends Node


@export var model_scale := 0.015
@export var background_scroll := 3.8
@export var player: Player


@onready var enemy_spawner: EnemySpawner = %EnemySpawner
@onready var background: Parallax2D = %Background
@onready var point_timer: Timer = $PointTimer
@onready var next_level: Area2D = %NextLevel


var _player_at_next_level := false


func _ready() -> void:
	background.scroll_scale = Vector2(background_scroll, background_scroll)
	# force update; works around Godot bug
	background.screen_offset = Vector2.ZERO


func try_complete_level() -> void:
	if not enemy_spawner.enemies.is_empty():
		return
	if not _player_at_next_level:
		return
	complete_level()


func complete_level() -> void:
	Global.health_bonus = int(player.health * 100.0)
	Global.speed_bonus = int(1000.0 * point_timer.time_left / point_timer.wait_time)
	
	Global.encrypted.state.level += 1
	Global.encrypted.state.score += Global.health_bonus + Global.speed_bonus
	
	Global.save_enc()
	
	await get_tree().create_timer(1.0).timeout
	
	get_tree().change_scene_to_packed(preload("res://src/menu/score_menu.tscn"))


func _on_next_level_body_entered(body: Node2D) -> void:
	if body == player:
		_player_at_next_level = true
		try_complete_level()
