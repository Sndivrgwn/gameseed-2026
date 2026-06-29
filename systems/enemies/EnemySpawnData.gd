extends Resource
class_name EnemySpawnData

@export_category("Enemy Spawn")

@export var enemy_scene : PackedScene
@export var spawn_interval : float = 0.2

@export_range(1,999) var amount := 1
