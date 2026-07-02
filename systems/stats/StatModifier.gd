extends Resource
class_name StatModifier

enum ModifierMode {
	FLAT,
	PERCENT
}

@export var stat_type : StatModifierType.Type
@export var mode : ModifierMode = ModifierMode.FLAT
@export var value : float = 0.0

static func create(
	type: StatModifierType.Type,
	amount: float,
	modifier_mode: ModifierMode = ModifierMode.FLAT
) -> StatModifier:
	var modifier := StatModifier.new()
	modifier.stat_type = type
	modifier.value = amount
	modifier.mode = modifier_mode
	return modifier
