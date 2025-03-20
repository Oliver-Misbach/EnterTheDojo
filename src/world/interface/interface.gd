extends CanvasLayer


@export var world: World


@onready var health_bar: ProgressBar = %HealthBar
@onready var level_name: Label = %LevelName

@onready var debug: Label = %Debug


func _ready() -> void:
	debug.visible = OS.is_debug_build()
	
	_update()


func _process(_delta: float) -> void:
	_update()


func _update() -> void:
	health_bar.value = world.player.health
	level_name.text = world.name
