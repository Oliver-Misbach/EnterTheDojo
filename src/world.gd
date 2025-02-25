class_name World
extends Node


#@export var next_scene: PackedScene
@export var player: Player


#@onready var player: Player = $Player
@onready var point_timer: Timer = $PointTimer
@onready var health_bar: ProgressBar = $CanvasLayer/PanelContainer/VBoxContainer/HBoxContainer/HealthBar
@onready var level_name: Label = $CanvasLayer/PanelContainer/VBoxContainer/LevelName


func _process(_delta: float) -> void:
	health_bar.value = player.health
	level_name.text = name


func _on_next_level_body_entered(body: Node2D) -> void:
	if body is Player:
		complete_level()


func complete_level() -> void:
	Global.health_bonus = int(player.health * 100.0)
	Global.speed_bonus = int(1000.0 * point_timer.time_left / point_timer.wait_time)
	
	Global.encrypted.state.level += 1
	Global.encrypted.state.score += Global.health_bonus + Global.speed_bonus
	
	Global.save_enc()
	
	get_tree().change_scene_to_packed(preload("res://src/menu/score_menu.tscn"))
	
