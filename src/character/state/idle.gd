extends State


@export var character: Character



func _enter() -> void:
	super._enter()
	
	_try_attack()


func _exit() -> void:
	super._exit()
	
	character.velocity.x = 0.0


func _physics_update(delta: float) -> void:
	super._physics_update(delta)
	
	if character.crouch:
		character.anim.play(&"idle_crouch")
	elif is_zero_approx(character.velocity.x):
		character.anim.play(&"idle")
	# TODO: Clean up handling for reverse animations for enemy.
	elif character.velocity.x * (1.0 if character is Player else -1.0) > 0.0:
		character.anim.play(&"walk_forward")
	else:
		character.anim.play(&"walk_backward")
	
	if character.is_on_floor():
		if character.crouch:
			character.velocity.x = 0.0
		else:
			character.velocity.x = character.movement * Character.SPEED
	
	_try_attack()


func _try_attack() -> void:
	if character.punch or character.kick:
		state_changed.emit(character.state_attack)
