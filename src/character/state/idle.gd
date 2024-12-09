extends State


@export var character: Character


func _exit() -> void:
	character.velocity.x = 0.0


func _physics_update(_delta: float) -> void:
	if character.is_on_floor():
		if character.crouch:
			character.velocity.x = 0.0
		else:
			character.velocity.x = character.movement * Character.SPEED
	
	if character.crouch:
		character.anim.play(&"idle_crouch")
	elif is_zero_approx(character.velocity.x):
		character.anim.play(&"idle")
	elif character.velocity.x > 0.0:
		character.anim.play(&"walk_forward")
	else:
		character.anim.play(&"walk_backward")
	
	if character.punch or character.kick:
		state_changed.emit($"../Attack")
