extends Resource
class_name EnemyData

@export_group("General")
@export var display_name := ""
@export_group("Stats")
@export var base_stats: StatData
@export_group("Resistance")
@export var resistance_data: ResistanceData
@export_group("Attack")
@export var attack_skill := ""
@export var attack_range := 40.0
@export var attack_cooldown := 1.0
@export_group("Movement")
@export var movement_strategy : MovementStrategy
@export_group("Reward")
@export var exp_reward := 20
