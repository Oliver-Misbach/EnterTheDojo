class_name Enemy
extends Character


const HIT_FRAMES := int(0.2 * 60.0)


@export var target: Player
@export var dodge_style: DodgeStyle


@onready var enemy_crouch_timer: Timer = %EnemyCrouchTimer
@onready var enemy_attack_timer: Timer = %EnemyAttackTimer

@onready var state_enemy_dodge: StateEnemyDodge = $StateMachine/EnemyDodge


var last_hurt_style: Array # [punch, crouch]


#var _has_changed_crouch := false


func _compute_dodge_chance(is_punch: bool, is_crouch: bool) -> float:
	# Note: This is overridden in boss.gd.
	
	var chance: float
	match [is_punch, is_crouch]:
		[false, false]:
			chance = dodge_style.kick_standing
		[false, true]:
			chance = dodge_style.kick_crouch
		[true, false]:
			chance = dodge_style.punch_standing
		[true, true]:
			chance = dodge_style.punch_crouch
	
	if last_hurt_style == [is_punch, is_crouch]:
		chance = maxf(chance, dodge_style.repeat_attack)
	
	return chance


func _physics_process(delta: float) -> void:
	assert(is_instance_valid(target), "Expected a valid player.")
	
	# TODO: Use state machine for enemy behavior.
	var offset := target.position.x - position.x
	if abs(offset) > abs(hurt_area.position.x * 2.0) + 1.0:
		movement = signf(offset)
		crouch = false
		punch = false
		kick = false
	elif state_machine.current == state_idle:
		movement = 0.0
		# Dodge if player attack winding up and enemy isn't attacking.
		if target.state_machine.current == target.state_attack \
				and not target.state_attack.hit_timer.is_stopped():
			# Probability of at least one attack over HIT_FRAMES attempts.
			var chance := _compute_dodge_chance(
				target.punch,
				target.crouch,
			)
			# chance = 1.0 - pow(1.0 - chance_per_frame, HIT_FRAMES)
			# chance_per_frame = 1.0 - pow(1.0 - chance, 1.0 / HIT_FRAMES)
			var chance_per_frame := 1.0 - pow(1.0 - chance, 1.0 / HIT_FRAMES)
			# TODO: delay randomly instead of dodging instantly
			#       this would remove the need to calculate chance_per_frame
			if randf() < chance_per_frame:
				_dodge()
				_restart_attack()
		elif target.state_machine.current != target.state_death:
			#if enemy_crouch_timer.is_stopped() and not _has_changed_crouch:
			if enemy_crouch_timer.is_stopped():
				#_has_changed_crouch = true
				_match_crouch()
			
			if enemy_attack_timer.is_stopped():
				_attack()
				_restart_attack()
	
	super._physics_process(delta)
	
	#var dodge_chance: float = _compute_dodge_chance(target.punch, target.crouch)
	#debug_label.text += "\nDodge: %d%%" % (dodge_chance * 100.0)


# Prevents the enemy from crouching/uncrouching too quickly.
func _restart_attack() -> void:
	#_has_changed_crouch = false
	
	enemy_crouch_timer.stop()
	enemy_crouch_timer.start()
	
	enemy_attack_timer.stop()
	enemy_attack_timer.start()


func _dodge() -> void:
	if target.crouch != crouch:
		return
	
	state_machine.current = state_enemy_dodge
	
	#print_debug("enemy dodging")


func _match_crouch() -> void:
	crouch = target.crouch
	#print("enemy matching with ", crouch)


func _attack() -> void:
	punch = true
	#print("enemy attacking")
