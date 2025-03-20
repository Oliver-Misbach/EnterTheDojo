class_name Character
extends CharacterBody2D


# used by EnemySpawner
@warning_ignore("UNUSED_SIGNAL")
signal death()


#const JUMP_VELOCITY = -400.0


@export var world: World
@export var speed := 70.0
@export var health := 1.0
@export var crouch_damage_multiplier := 1.3

## Set to animation timings.
## TODO: Could be auto-detected, but we may want the game to work without animations (e.g. serverside).
@export_group("Time", "time_")
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_punch_hit := 0.2       # | 200ms | Punch hit      |
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_punch_standing := 0.4  # | 400ms | Punch standing |
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_punch_crouch := 0.5    # | 500ms | Punch crouch   |
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_kick_hit := 0.3        # | 300ms | Kick hit       |
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_kick_standing := 0.667 # | 667ms | Kick standing  |
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var time_kick_crouch := 0.8     # | 800ms | Kick crouch    |


@onready var hurt_area: Area2D = $HurtArea
@onready var model: Node3D = $Player_Character
@onready var anim: AnimationPlayer = $Player_Character/AnimationPlayer

@onready var sound_block: AudioStreamPlayer = %Block
@onready var sound_duck: AudioStreamPlayer = %Duck
@onready var sound_kick: AudioStreamPlayer = %Kick
@onready var sound_punch_swing: AudioStreamPlayer = %PunchSwing
@onready var sound_punch_hit: AudioStreamPlayer = %PunchHit

@onready var state_machine: StateMachine = $StateMachine
@onready var state_idle: State = $StateMachine/Idle
@onready var state_attack: State = $StateMachine/Attack
@onready var state_hurt: State = $StateMachine/Hurt
@onready var state_death: State = $StateMachine/Death

#@onready var debug_label: Label3D = $Player_Character/DebugLabel


var movement: float
var punch: bool
var kick: bool
#var jump: bool
var crouch: bool


func _ready() -> void:
	update_model_position()


func _process(_delta: float) -> void:
	update_model_position()


func _physics_process(_delta: float) -> void:
	#print(name, " physics process: ", state_machine.current.name)
	
	#debug_label.text = "State: %s" % state_machine.current.name
	#if state_machine.current == state_attack:
		#debug_label.text += "\n" + ("wind down" if state_attack.hit_timer.is_stopped() else "wind up")
	
	#velocity += get_gravity() * delta
	
	#if jump and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	move_and_slide()


func update_model_position() -> void:
	#model.position = Vector3(position.x, 0.0, 0.0)
	model.position = Vector3(position.x * world.model_scale, 0.0, 0.0)


func can_damage() -> bool:
	if state_machine.current == state_idle:
		return true
	if not state_attack.hit_timer.is_stopped():
		return true
	return false


func damage() -> void:
	if crouch:
		health -= crouch_damage_multiplier
	else:
		health -= 1.0
	
	if health <= 0.0:
		state_machine.current = state_death
	else:
		state_machine.current = state_hurt
