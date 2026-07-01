extends Node
class_name StatsComponent

@export var base_stats : StatData
var modifiers : Array[StatModifier] = []

var hp : int
var mana : int

signal hp_changed
signal mana_changed
signal died

func _ready():
	hp = get_max_hp()
	mana = get_max_mana()

func get_critical_rate() -> float:
	var value = base_stats.critical_rate
	value += get_flat_modifier(
		StatModifierType.Type.CRITICAL_RATE
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.CRITICAL_RATE
		)
	)
	return value

func get_critical_multiplier() -> float:
	var value = base_stats.critical_multiplier
	value += get_flat_modifier(
		StatModifierType.Type.CRITICAL_MULTIPLIER
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.CRITICAL_MULTIPLIER
		)
	)
	return value
	
func get_attack() -> int:
	var value = base_stats.attack
	value += get_flat_modifier(
		StatModifierType.Type.ATTACK
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.ATTACK
		)
	)
	return int(round(value))

func get_magic_attack() -> int:
	var value = base_stats.magic_attack
	value += get_flat_modifier(
		StatModifierType.Type.MAGIC_ATTACK
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.MAGIC_ATTACK
		)
	)
	return int(round(value))

func get_defense() -> int:
	var value = base_stats.defense
	value += get_flat_modifier(
		StatModifierType.Type.DEFENSE
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.DEFENSE
		)
	)
	return int(round(value))

func get_magic_defense() -> int:
	var value = base_stats.magic_defense
	value += get_flat_modifier(
		StatModifierType.Type.MAGIC_DEFENSE
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.MAGIC_DEFENSE
		)
	)
	return int(round(value))

func get_speed() -> float:
	var value = base_stats.move_speed
	value += get_flat_modifier(
		StatModifierType.Type.MOVE_SPEED
	)
	value *= (
		1.0 +
		get_percent_modifier(
			StatModifierType.Type.MOVE_SPEED
		)
	)
	return value

func get_max_hp():
	return base_stats.max_hp

func get_max_mana():
	return base_stats.max_mana

func take_damage(hit : HitResult):
	hp -= hit.damage_data.amount
	hp = max(0, hp)
	hp_changed.emit(hp)
	if hp <= 0:
		died.emit()

func heal(amount : int):

	hp += amount

	hp = min(hp, get_max_hp())

	hp_changed.emit(hp)

func spend_mana(amount : int):

	if mana < amount:
		return false

	mana -= amount

	mana_changed.emit(mana)

	return true

func restore_mana(amount : int):

	mana += amount

	mana = min(mana, get_max_mana())

	mana_changed.emit(mana)

func add_modifier(modifier: StatModifier):
	modifiers.append(modifier)
	
func remove_modifier(modifier: StatModifier):
	modifiers.erase(modifier)
	
func get_flat_modifier(
	type: StatModifierType.Type
) -> float:
	var total := 0.0
	for modifier in modifiers:
		if modifier.stat_type != type:
			continue
		if modifier.mode != StatModifier.ModifierMode.FLAT:
			continue
		total += modifier.value
	return total

func get_percent_modifier(
	type: StatModifierType.Type
) -> float:
	var total := 0.0
	for modifier in modifiers:
		if modifier.stat_type != type:
			continue
		if modifier.mode != StatModifier.ModifierMode.PERCENT:
			continue
		total += modifier.value
	return total
