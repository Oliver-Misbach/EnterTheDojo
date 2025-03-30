extends Node


@onready var health_bonus: Label = $CenterContainer/TextureRect/HealthBonus
@onready var speed_bonus: Label = $CenterContainer/TextureRect/SpeedBonus


func _ready() -> void:
	health_bonus.text = str(Global.health_bonus)
	speed_bonus.text = str(Global.speed_bonus)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	
	if event is InputEventKey:
		if event.pressed:
			change_to_level()


func change_to_level() -> void:
	Global.change_to_level()
