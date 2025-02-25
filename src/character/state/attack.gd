extends State


@export var character: Character


@onready var hit_timer: Timer = $HitTimer
@onready var timer: Timer = $Timer


var _crouch: bool


func _enter() -> void:
	#print("Attack state: ", character.punch, "; ", character.crouch)
	super._enter()
	
	_crouch = character.crouch
	
	# Fix same animation not repeating.
	character.anim.stop()
	#character.anim.seek(0.0)
	
	if character.punch:
		hit_timer.start(0.2) # Punch hit time: 200ms
		if _crouch:
			timer.start(0.5) # Punch crouch: 500ms
			character.anim.play(&"punch_crouch")
		else:
			timer.start(0.4) # Punch standing: 400ms
			character.anim.play(&"punch_standing")
	else:
		hit_timer.start(0.3) # Kick hit time: 300ms
		if _crouch:
			timer.start(0.8) # Kick crouch: 800ms
			character.anim.play(&"kick_crouch")
		else:
			timer.start(0.667) # Kick standing: 667ms
			character.anim.play(&"kick_standing")


func _exit() -> void:
	super._exit()
	
	hit_timer.stop()
	timer.stop()


func _on_hit_timer_timeout() -> void:
	for body in character.hurt_area.get_overlapping_bodies():
		if body != character and body is Character:
			#print(character.name, " try hurt... ", body.name, "; ", character.crouch, ", ", body.crouch)
			if _crouch == body.crouch:
				body.try_damage()
			break


func _on_timer_timeout() -> void:
	state_changed.emit(character.state_idle)
