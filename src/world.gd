extends Node


@export var next_scene: PackedScene


@onready var player: Player = $Player
@onready var point_timer: Timer = $PointTimer
@onready var health_bar: ProgressBar = $CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/HealthBar


func _process(_delta: float) -> void:
	health_bar.value = player.health


func _on_next_level_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.next_scene = next_scene
		Global.health_bonus = player.health * 10
		Global.speed_bonus = int(1000.0 * point_timer.time_left / point_timer.wait_time)
		Global.state.score += Global.health_bonus + Global.speed_bonus
		get_tree().change_scene_to_packed(preload("res://src/menu/score_menu.tscn"))
