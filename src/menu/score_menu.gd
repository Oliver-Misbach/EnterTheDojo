extends Node


@onready var health_bonus: Label = $CenterContainer/TextureRect/HealthBonus
@onready var speed_bonus: Label = $CenterContainer/TextureRect/SpeedBonus


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			_on_timer_timeout()


func _ready() -> void:
	health_bonus.text = str(Global.health_bonus)
	speed_bonus.text = str(Global.speed_bonus)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(Global.next_scene)
