extends State


@export var character: Character


var crouch: bool
var punch: bool


@onready var hit_timer: Timer = $HitTimer
@onready var timer: Timer = $Timer


func _enter() -> void:
	print(character, ": ATTACK")
	
	# Alternatively, only let these update from Idle.
	crouch = character.crouch
	punch = character.punch
	
	hit_timer.start()
	timer.start()
	
	if punch:
		if crouch:
			character.anim.play(&"punch_crouch")
		else:
			character.anim.play(&"punch_standing")
	else:
		if crouch:
			character.anim.play(&"kick_crouch")
		else:
			character.anim.play(&"kick_standing")


func _exit() -> void:
	hit_timer.stop()
	timer.stop()


func _on_hit_timer_timeout() -> void:
	for body in character.hurt_area.get_overlapping_bodies():
		if body != self and body is Character:
			if crouch == body.crouch:
				body.damage()
			break


func _on_timer_timeout() -> void:
	state_changed.emit($"../Idle")
