extends State


@export var character: Character


var _last_crouch: bool


func _exit() -> void:
	super._exit()
	
	character.velocity.x = 0.0


func _physics_frame(delta: float) -> void:
	super._physics_frame(delta)
	
	_update_animation()
	
	#if character.is_on_floor():
	if character.crouch:
		character.velocity.x = 0.0
	else:
		character.velocity.x = character.movement * character.speed
	
	if character.crouch and not _last_crouch:
		character.sound_duck.play()
	_last_crouch = character.crouch
	
	_try_attack()


func _update_animation() -> void:
	if character.crouch:
		character.anim.play(&"idle_crouch")
	elif is_zero_approx(character.velocity.x):
		character.anim.play(&"idle")
	# TODO: Clean up handling for reverse animations for enemy.
	elif character.velocity.x * (1.0 if character is Player else -1.0) > 0.0:
		character.anim.play(&"walk_forward")
	else:
		character.anim.play(&"walk_backward")


func _try_attack() -> void:
	if character.punch or character.kick:
		#state_changed.emit(character.state_attack)
		character.state_machine.current = character.state_attack
