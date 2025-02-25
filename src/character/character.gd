class_name Character
extends CharacterBody2D


# used by EnemySpawner
@warning_ignore("UNUSED_SIGNAL")
signal death()


const SPEED = 200.0
#const JUMP_VELOCITY = -400.0


@export var health := 1.0
@export var crouch_damage_multiplier := 1.3


var movement: float
var punch: bool
var kick: bool
#var jump: bool
var crouch: bool


@onready var hurt_area: Area2D = $HurtArea
@onready var model: Node3D = $Player_Character
@onready var anim: AnimationPlayer = $Player_Character/AnimationPlayer

@onready var state_machine: StateMachine = $StateMachine
@onready var state_idle: State = $StateMachine/Idle
@onready var state_attack: State = $StateMachine/Attack
@onready var state_hurt: State = $StateMachine/Hurt
@onready var state_death: State = $StateMachine/Death

#@onready var debug_label: Label3D = $Player_Character/DebugLabel


func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	#print(name, " physics process: ", state_machine.current.name)
	
	#debug_label.text = "State: %s" % state_machine.current.name
	#if state_machine.current == state_attack:
		#debug_label.text += "\n" + ("wind down" if state_attack.hit_timer.is_stopped() else "wind up")
	
	velocity += get_gravity() * delta
	
	#if jump and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
	model.position = Vector3(position.x / 64.0, -position.y / 64.0, 0.0)

func try_damage() -> void:
	#print("Damage ", name, ": ", state_attack.hit_timer.is_stopped())
	
	# You can be damaged during idle and attack wind up.
	if state_machine.current == state_idle or not state_attack.hit_timer.is_stopped():
		damage()


func damage() -> void:
	if crouch:
		health -= crouch_damage_multiplier
	else:
		health -= 1.0
	
	if health <= 0.0:
		state_machine.current = state_death
	else:
		state_machine.current = state_hurt
