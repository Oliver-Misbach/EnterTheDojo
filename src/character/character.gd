class_name Character
extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


@export var health := 100


var movement: float
var punch: bool
var kick: bool
#var jump: bool
var crouch: bool


@onready var hurt_area: Area2D = $HurtArea
@onready var model: Node3D = $Player_Character
@onready var anim: AnimationPlayer = $Player_Character/AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine


func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	#if jump and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
	model.position = Vector3(position.x / 64.0, -position.y / 64.0, 0.0)

func damage() -> void:
	if state_machine.current != $StateMachine/Hurt:
		state_machine.current = $StateMachine/Hurt
