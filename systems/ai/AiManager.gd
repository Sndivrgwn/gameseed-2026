extends Node
class_name AIManager

static var instance: AIManager

var enemies: Array[Enemy] = []

func _ready():
	instance = self

func register_enemy(enemy: Enemy):
	if enemy not in enemies:
		enemies.append(enemy)

func unregister_enemy(enemy: Enemy):
	enemies.erase(enemy)

func get_alive_enemies() -> Array[Enemy]:
	enemies = enemies.filter(func(e):
		return is_instance_valid(e)
	)
	return enemies
