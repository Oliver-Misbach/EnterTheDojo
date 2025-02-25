extends CanvasLayer


@export var world: World


@onready var health_bar: ProgressBar = %HealthBar
@onready var level_name: Label = %LevelName


func _process(_delta: float) -> void:
	health_bar.value = world.player.health
	level_name.text = world.name
