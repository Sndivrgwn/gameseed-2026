extends Node
class_name StatsComponent

@export var base_stats : StatData

var hp : int
var mana : int

signal hp_changed
signal mana_changed
signal died

func _ready():
	hp = base_stats.max_hp
	mana = base_stats.max_mana
	
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

func take_damage(amount):
	hp -= amount
	print(owner.name, " HP :", hp)
	hp_changed.emit(hp)
	if hp <= 0:
		died.emit()

func spend_mana(amount):
	if mana < amount:
		return false
	mana -= amount
	mana_changed.emit(mana)
	return true

func die():
	get_parent().queue_free()
	
func heal(amount : int):
	hp += amount

	if hp > base_stats.max_hp:
		hp = base_stats.max_hp
