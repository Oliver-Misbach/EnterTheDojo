extends "res://src/character/state/hurt.gd"


#var _last_crouch: bool


func _enter() -> void:
	super._enter()
	
	var style := BossComboItem.new(punch, crouch)
	
	if character.last_attack_style != null:
		if not BossComboItem.eq(character.last_attack_style, style):
			character.attack_style_repeats = 0
	
	character.attack_style_repeats += 1
	character.last_attack_style = style
	
	print_debug("boss hurt: style = (", punch, ", ", crouch, "), repeats = ", character.attack_style_repeats)
