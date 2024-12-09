extends State


@export var character: Character


@onready var timer: Timer = $Timer


func _enter() -> void:
	print(character, ": HURT")
	
	timer.start()
	
	if character.crouch:
		character.anim.play(&"hit_react_crouching")
	else:
		character.anim.play(&"hit_react_standing")
	
	character.health -= 10
	if character.health <= 0:
		character.queue_free()


func _on_timer_timeout() -> void:
	state_changed.emit($"../Idle")
