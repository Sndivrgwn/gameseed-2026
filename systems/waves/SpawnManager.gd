extends Node
class_name SpawnManager

@export var enemy_container : Node2D
@export var spawn_points : Array[Marker2D]
@export var wave_manager: WaveManager

var alive_enemies : Array[Enemy]
var spawn_queue : Array[SpawnRequest] = []
var is_spawning := false
signal enemy_spawned(enemy)
signal queue_finished

func _ready():
	wave_manager.wave_started.connect(
		_on_wave_started
	)

func enqueue(data: EnemySpawnData):
	print("Enqueue:", data.enemy_scene)
	var request = SpawnRequest.new(
		data.enemy_scene,
		data.amount,
		data.spawn_interval
	)
	spawn_queue.append(request)
	if !is_spawning:
		process_queue()

func process_queue():
	print("Process Queue")
	if is_spawning:
		print("Already spawning")
		return
	is_spawning = true
	while spawn_queue.size() > 0:
		print("Queue Size:", spawn_queue.size())
		var request = spawn_queue.pop_front()
		await spawn_request(request)
	is_spawning = false

func spawn_request(request : SpawnRequest):
	for i in request.amount:
		spawn_enemy(request.enemy_scene)
		if request.interval > 0:
			await get_tree().create_timer(
				request.interval
			).timeout

func spawn_enemy(scene : PackedScene):
	if spawn_points.is_empty():
		return
	print("spawning enemy")
	var enemy = scene.instantiate()
	alive_enemies.append(enemy)
	var point = spawn_points.pick_random()
	enemy.global_position = point.global_position
	enemy_container.add_child(enemy)	
	enemy_spawned.emit(enemy)

func _on_wave_started(wave_index: int, wave: WaveData):
	print("Wave Started:", wave.wave_name)

	for enemy_data in wave.enemies:
		print(enemy_data.enemy_scene)
		print(enemy_data.amount)

		enqueue(enemy_data)
