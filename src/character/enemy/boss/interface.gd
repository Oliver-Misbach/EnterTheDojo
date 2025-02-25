extends CanvasLayer


@export var boss: Boss


@onready var progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	_update()


func _process(_delta: float) -> void:
	_update()


func _update() -> void:
	progress_bar.value = boss.health
