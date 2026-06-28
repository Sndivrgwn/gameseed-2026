extends RefCounted
class_name StatModifier

enum ModifierMode {
	FLAT,
	PERCENT
}

var stat_type : StatModifierType.Type
var mode : ModifierMode = ModifierMode.FLAT
var value : float = 0.0

func _init(
	type: StatModifierType.Type,
	amount: float,
	modifier_mode : ModifierMode = ModifierMode.FLAT
):
	stat_type = type
	value = amount
	mode = modifier_mode
