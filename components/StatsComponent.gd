extends Node
class_name StatsComponent

@export var base_stats : StatData

var hp : int
var mana : int

signal hp_changed
signal mana_changed
signal died

func _ready():
	hp = get_max_hp()
	mana = get_max_mana()

func get_critical_rate() -> float:
	return base_stats.critical_rate

func get_critical_multiplier() -> float:
	return base_stats.critical_multiplier
	
func get_attack():
	return base_stats.attack

func get_magic_attack():
	return base_stats.magic_attack

func get_defense():
	return base_stats.defense

func get_magic_defense():
	return base_stats.magic_defense

func get_speed():
	return base_stats.move_speed

func get_max_hp():
	return base_stats.max_hp

func get_max_mana():
	return base_stats.max_mana

func take_damage(hit : HitResult):
	print("damage: ", hit.damage_data.amount)
	hp -= hit.damage_data.amount
	hp = max(0, hp)
	hp_changed.emit(hp)
	print("hp: ", hp)
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
