extends State


@export var character: Character


@onready var timer: Timer = $Timer


var punch: bool
var crouch: bool


func _enter() -> void:
	super._enter()
	
	timer.start()
	
	if character.crouch:
		character.anim.play(&"hit_react_crouching")
	else:
		character.anim.play(&"hit_react_standing")


func _on_timer_timeout() -> void:
	#state_changed.emit(character.state_idle)
	character.state_machine.current = character.state_idle
