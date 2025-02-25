extends State


@export var character: Character


@onready var timer: Timer = $Timer


func _enter() -> void:
	super._enter()
	
	timer.start()
	
	character.anim.play(&"death")


func _on_timer_timeout() -> void:
	character.death.emit()
	character.process_mode = Node.PROCESS_MODE_DISABLED
