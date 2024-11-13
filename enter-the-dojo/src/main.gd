extends Node

@onready var player: Player = $Player
@onready var health_bar: ProgressBar = $PanelContainer/VBoxContainer/HBoxContainer/HealthBar

func _process(_delta: float) -> void:
	health_bar.value = player.health
