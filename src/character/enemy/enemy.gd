class_name Enemy
extends Character


const HIT_FRAMES := int(0.2 * 60.0)


@export var target: Player


@onready var enemy_crouch_timer: Timer = %EnemyCrouchTimer
@onready var enemy_attack_timer: Timer = %EnemyAttackTimer


var last_hurt_style: Array # [punch, crouch]


var _has_changed_crouch := false


func _compute_dodge_chance(is_punch: bool, is_crouch: bool) -> float:
	# Note: This is overridden in boss.gd.
	match scene_file_path:
		#"res://src/character/enemy.tscn":
			## Testing. Block punches and crouching.
			#return 1.0 if is_punch or is_crouch else 0.0
		"res://src/character/enemy/blue.tscn":
			pass # Blue: No blocking.
		"res://src/character/enemy/yellow.tscn":
			if is_punch:
				return 0.6 # Yellow: 60% of punches.
		"res://src/character/enemy/green.tscn":
			if not is_punch:
				return 0.6 # Green: 60% of kicks.
		"res://src/character/enemy/red.tscn":
			if not is_crouch:
				return 0.8 # Red: 80% of standing attacks.
		"res://src/character/enemy/black.tscn":
			if last_hurt_style == [is_punch, is_crouch]:
				return 1.0 # Black: 100% of same style attacks.
	return 0.0


func _physics_process(delta: float) -> void:
	assert(is_instance_valid(target), "Expected a valid player.")
	
	# TODO: Use state machine for enemy behavior.
	var offset := target.position.x - position.x
	if abs(offset) > abs(hurt_area.position.x * 2.0) + 1.0:
		movement = signf(offset)
		crouch = false
		punch = false
		kick = false
	else:
		movement = 0.0
		# Dodge if attack winding up and player isn't attacking.
		if target.state_machine.current == target.state_attack \
				and not target.state_attack.hit_timer.is_stopped() \
				and state_machine.current != state_attack:
			# Dodge attacks.
			var chance := _compute_dodge_chance(
				target.punch,
				target.crouch,
			)
			# TODO: 100% chance: delay randomly?
			if randf() > pow(1.0 - chance, 1.0 / HIT_FRAMES):
				_dodge_crouch()
				_reset_attack()
		else:
			if state_machine.current == state_idle:
				if enemy_crouch_timer.is_stopped() and not _has_changed_crouch:
					_has_changed_crouch = true
					_match_crouch()
				
				if enemy_attack_timer.is_stopped():
					_has_changed_crouch = false
					_attack()
					
					enemy_crouch_timer.start()
					enemy_attack_timer.start()
	
	super._physics_process(delta)
	
	#var dodge_chance: float = _compute_dodge_chance(target.punch, target.crouch)
	#debug_label.text += "\nDodge: %d%%" % (dodge_chance * 100.0)


# Prevents the enemy from crouching/uncrouching too quickly.
func _reset_attack() -> void:
	_has_changed_crouch = false
	
	enemy_crouch_timer.stop()
	enemy_crouch_timer.start()
	
	enemy_attack_timer.stop()
	enemy_attack_timer.start()


func _dodge_crouch() -> void:
	crouch = not target.crouch
	#print("enemy dodging with ", crouch)


func _match_crouch() -> void:
	crouch = target.crouch
	#print("enemy matching with ", crouch)


func _attack() -> void:
	punch = true
	#print("enemy attacking")
