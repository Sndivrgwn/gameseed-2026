extends Resource
class_name WaveData

@export_category("Wave")

@export_group("General")

@export var wave_name : String = ""
@export var duration : float = 30.0

@export_group("Enemies")

@export var enemies : Array[EnemySpawnData]
