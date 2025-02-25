extends CanvasLayer


@export var boss: Boss


@onready var progress_bar: ProgressBar = %ProgressBar


func _process(_delta: float) -> void:
	progress_bar.value = boss.health
