class_name StateEnemyDodge
extends State


@export var character: Character


@onready var timer: Timer = $Timer


func _enter() -> void:
	character.sound_block.play()
	
	timer.start()
	
	if character.crouch:
		character.anim.play(&"block_crouching")
	else:
		character.anim.play(&"block_standing")


func _on_timer_timeout() -> void:
	#state_changed.emit(character.state_idle)
	character.state_machine.current = character.state_idle
