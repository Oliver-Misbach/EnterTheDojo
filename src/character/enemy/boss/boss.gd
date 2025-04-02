class_name Boss
extends Enemy


@export var combo_types: Array[BossCombo]
@export var dodge_chance := 0.3
@export var repeat_dodge_chance := 1.0
@export var dodge_after_repeats := 3

@export_group("Time", "time_")
@export var time_combo_move := 0.5


var combo_queue: Array[BossComboItem]

var last_attack_style: BossComboItem
var attack_style_repeats: int


func _compute_dodge_chance(_is_punch: bool, is_crouch: bool) -> float:
	if last_attack_style != null and last_attack_style.crouch == is_crouch:
		if attack_style_repeats >= dodge_after_repeats:
			return repeat_dodge_chance
	return dodge_chance


func _attack() -> void:
	if not combo_queue.is_empty():
		_restart_attack()
		return
	
	var combo: BossCombo = combo_types.pick_random()
	combo_queue = combo.items.duplicate()
	
	#print("[Boss] Combo: ", combo_queue.map(func(move): return [
		#"Punch" if move.punch else "Kick",
		#"Crouch" if move.crouch else "Standing",
	#]))
	
	next_combo_move()


func queue_next_combo_move() -> void:
	if combo_queue.is_empty():
		_restart_attack()
		return
	
	var timer := get_tree().create_timer(time_combo_move)
	G.ok(timer.timeout.connect(next_combo_move))


func next_combo_move() -> void:
	var move: BossComboItem = combo_queue.pop_front()
	assert(move != null)
	
	punch = move.punch
	kick = not move.punch
	crouch = move.crouch
	
	#print("[Boss] Next move: punch = ", punch, "; crouch = ", crouch)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
