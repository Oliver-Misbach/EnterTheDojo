extends State


@export var character: Character


@onready var hit_timer: Timer = %HitTimer
@onready var timer: Timer = %Timer


var punch: bool
var crouch: bool


func _enter() -> void:
	#print("Attack state: ", character.punch, "; ", character.crouch)
	super._enter()
	
	# Input is not affected by the state machine. Save this attack's input for later.
	punch = character.punch
	crouch = character.crouch
	
	# Fix same animation not repeating.
	character.anim.stop()
	#character.anim.seek(0.0)
	
	character.sound_swing.play()
	
	if punch:
		hit_timer.start(character.time_punch_hit)
		if crouch:
			timer.start(character.time_punch_crouch)
			character.anim.play(&"punch_crouch")
		else:
			timer.start(character.time_punch_standing)
			character.anim.play(&"punch_standing")
	else:
		hit_timer.start(character.time_kick_hit)
		if crouch:
			timer.start(character.time_kick_crouch)
			character.anim.play(&"kick_crouch")
		else:
			timer.start(character.time_kick_standing)
			character.anim.play(&"kick_standing")


func _exit() -> void:
	super._exit()
	
	hit_timer.stop()
	timer.stop()


func _hit(body: Character) -> void:
	if punch:
		character.sound_punch.play()
	else:
		character.sound_kick.play()
	
	body.damage(punch, crouch)


func _test_hurt_area() -> Character:
	for body in character.hurt_area.get_overlapping_bodies():
		if body != character and body is Character:
			#print(character.name, " try hurt... ", body.name, "; ", character.crouch, ", ", body.crouch)
			if crouch != body.crouch:
				continue
			if not body.can_damage():
				continue
			return body
	return null


func _on_hit_timer_timeout() -> void:
	var body := _test_hurt_area()
	if body != null:
		_hit(body)


func _on_timer_timeout() -> void:
	#state_changed.emit(character.state_idle)
	character.state_machine.current = character.state_idle
