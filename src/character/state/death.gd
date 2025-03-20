extends State


@export var character: Character


@onready var timer: Timer = $Timer


func _enter() -> void:
	super._enter()
	
	#timer.start()
	
	character.anim.play(&"death")


#func _death() -> void:
	#pass


#func _on_timer_timeout() -> void:
	#_death()
