class_name Boss
extends Enemy


var combo_queue: Array
var last_crouch: bool
var crouch_repeats: int


func _compute_dodge_chance(_is_punch: bool, is_crouch: bool) -> float:
	if crouch_repeats >= 3 and last_crouch == is_crouch:
		return 1.0 # Block after same crouch used 3 times in a row.
	return 0.3 # Block 30%


func _process(delta: float) -> void:
	super._process(delta)
	$CanvasLayer/ProgressBar.value = health


func _enemy_attack() -> void:
	#print("Boss enemy attack... ", punch, ", ", crouch)
	
	# [[[is_punch, is_crouch], ...] ...]
	combo_queue = [
		# punch, kick, punch
		[[true, false], [false, false], [true, false]],
		# crouch kick, punch
		[[false, true], [true, false]],
		# punch, punch
		[[true, false], [true, false]],
		# crouch kick, crouch kick
		[[false, true], [false, true]],
		# kick, crouch punch
		[[false, false], [true, true]],
	].pick_random()
	print("[Boss] ", combo_queue.map(func(move): return ["Punch" if move[0] else "Kick", "Crouch" if move[1] else "Standing"]))
	next_combo_move()


func next_combo_move() -> void:
	var move = combo_queue.pop_front()
	if move != null:
		if move[0]:
			punch = true
		else:
			kick = true
		crouch = move[1]
	#print("[Boss] Next move: ", punch, "; ", kick, "; ", crouch)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
