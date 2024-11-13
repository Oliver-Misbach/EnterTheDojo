class_name Character
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var health := 100


var movement: float
var punch: bool
var kick: bool
var jump: bool
var crouch: bool


@onready var hurt_area: Area2D = $HurtArea
@onready var hurt_timer: Timer = $HurtTimer


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if jump and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		velocity.x = movement * SPEED
	
	move_and_slide()
	
	$Sprite2D.position.y = 10.0 if crouch else 0.0
	
	if not is_zero_approx(velocity.x):
		hurt_area.position.x = -8.0 if velocity.x < 0.0 else 8.0
		$Player_Character/Karate_Man.rotation.y = PI * 1.5 if velocity.x < 0.0 else PI * 0.5
	$Player_Character.position = Vector3(position.x / 64.0, -position.y / 64.0, 0.0)
	
	if punch or kick:
		if hurt_timer.is_stopped():
			hurt_timer.start()
			for body in hurt_area.get_overlapping_bodies():
				if body != self and body is Character:
					if crouch == body.crouch:
						body.damage()
					break

func damage() -> void:
	health -= 10
	if health <= 0:
		queue_free()
