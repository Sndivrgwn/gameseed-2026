extends Resource
class_name EnemyData

@export_group("General")
@export var display_name := ""

@export_group("Stats")
@export var base_stats: StatData
@export var resistance_data: ResistanceData

@export_group("Combat")
@export var attack_skill: StringName
@export var attack_range := 40.0

@export_group("Reward")
@export var exp_reward := 20
