extends Node
class_name ResistanceComponent

var resistances: Dictionary = {}
const MIN_RESISTANCE := -1.0
const MAX_RESISTANCE := 0.9

func _ready():
	for element in CombatTypes.ElementType.values():
		resistances[element] = 0.0

func get_resistance(element: CombatTypes.ElementType) -> float:
	return resistances.get(element, 0.0)

func set_resistance(element, value):

	resistances[element] = clamp(
		value,
		MIN_RESISTANCE,
		MAX_RESISTANCE
	)

func add_resistance(
	element: CombatTypes.ElementType,
	value: float
):
	resistances[element] += value

func is_immune(element):
	return get_resistance(element) >= 1.0

func is_weak(element):
	return get_resistance(element) < 0

func is_resistant(element):
	return get_resistance(element) > 0

func load(data: ResistanceData):

	set_resistance(
		CombatTypes.ElementType.FIRE,
		data.fire
	)

	set_resistance(
		CombatTypes.ElementType.ICE,
		data.ice
	)

	set_resistance(
		CombatTypes.ElementType.LIGHTNING,
		data.lightning
	)

	set_resistance(
		CombatTypes.ElementType.WATER,
		data.water
	)

	set_resistance(
		CombatTypes.ElementType.WIND,
		data.wind
	)

	set_resistance(
		CombatTypes.ElementType.EARTH,
		data.earth
	)

	set_resistance(
		CombatTypes.ElementType.HOLY,
		data.holy
	)

	set_resistance(
		CombatTypes.ElementType.DARK,
		data.dark
	)
