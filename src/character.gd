class_name Character
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var health := 100


var movement: float
var punch: bool
var kick: bool
#var jump: bool
var crouch: bool


@onready var hurt_area: Area2D = $HurtArea
@onready var hurt_timer: Timer = $HurtTimer
@onready var hit_timer: Timer = $HitTimer # Used for animations.
@onready var model: Node3D = $Player_Character
#@onready var model_character: Node3D = $Player_Character/Karate_Man_Rig # Work around camera rotating with character.
@onready var anim: AnimationPlayer = $Player_Character/AnimationPlayer


func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	#if jump and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		if crouch or not hurt_timer.is_stopped() or not hit_timer.is_stopped():
			velocity.x = 0.0
		else:
			velocity.x = movement * SPEED
	
	move_and_slide()
	
	if hurt_timer.is_stopped() and hit_timer.is_stopped():
		if crouch:
			anim.play(&"idle_crouch")
		elif is_zero_approx(velocity.x):
			anim.play(&"idle")
		elif velocity.x > 0.0:
			anim.play(&"walk_forward")
		else:
			anim.play(&"walk_backward")
	
	if not is_zero_approx(velocity.x):
		hurt_area.scale.x = -1.0 if velocity.x < 0.0 else 1.0
		#model.get_child(0).rotation.y = PI * 1.5 if velocity.x < 0.0 else PI * 0.5
	model.position = Vector3(position.x / 64.0, -position.y / 64.0, 0.0)
	
	if punch or kick:
		if hurt_timer.is_stopped():
			hurt_timer.start()
			
			if punch:
				if crouch:
					anim.play(&"punch_crouch")
				else:
					anim.play(&"punch_standing")
			else:
				if crouch:
					anim.play(&"kick_crouch")
				else:
					anim.play(&"kick_standing")
			
			for body in hurt_area.get_overlapping_bodies():
				if body != self and body is Character:
					if crouch == body.crouch:
						body.damage()
					break

func damage() -> void:
	# Restart timer (for animations).
	hit_timer.stop()
	hit_timer.start()
	
	if crouch:
		anim.play(&"hit_react_crouching")
	else:
		anim.play(&"hit_react_standing")
	
	health -= 10
	if health <= 0:
		queue_free()
