class_name World
extends Node


@onready var player: Player = $Player
@onready var point_timer: Timer = $PointTimer


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
	
