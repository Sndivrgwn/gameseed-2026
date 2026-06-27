extends Resource
class_name StatData

@export var max_hp := 100
@export var max_mana := 100

@export var attack := 10
@export var magic_attack := 10

@export var defense := 5
@export var magic_defense := 5

@export var move_speed := 200.0

@export_range(0.0, 1.0) var critical_rate := 0.05

@export var critical_multiplier := 1.5
@export var damage_type := CombatTypes.DamageType.MAGICAL
