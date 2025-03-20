class_name BossComboItem
extends Resource


@export var punch: bool
@export var crouch: bool


func _init(_punch := false, _crouch := false) -> void:
	punch = _punch
	crouch = _crouch


static func eq(a: BossComboItem, b: BossComboItem) -> bool:
	return \
			a.punch == b.punch and \
			a.crouch == b.crouch and \
			true
