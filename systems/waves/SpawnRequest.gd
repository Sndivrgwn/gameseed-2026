extends RefCounted
class_name SpawnRequest

var enemy_scene : PackedScene
var amount : int
var interval : float

func _init(
	scene : PackedScene,
	count : int,
	spawn_interval : float
):
	enemy_scene = scene
	amount = count
	interval = spawn_interval
