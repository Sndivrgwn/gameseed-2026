extends Node
class_name SpawnManager

signal enemy_spawned(enemy)
signal queue_finished

@export var enemy_container: Node2D
@export var wave_manager: WaveManager
@export var player: BaseCharacter

@export_group("Spawn")
@export var spawn_margin := 150.0
@export var min_spawn_distance := 500.0
@export var camera_manager: CameraManager
@export_range(0.5, 1.0) var forward_spawn_chance := 0.8

var alive_enemies: Array[Enemy] = []
var spawn_queue: Array[SpawnRequest] = []

var is_spawning := false

func _ready():
	add_to_group("spawn_manager")
	wave_manager.wave_started.connect(_on_wave_started)

func enqueue(data: EnemySpawnData):
	var request := SpawnRequest.new(
		data.enemy_scene,
		data.amount,
		data.spawn_interval
	)
	spawn_queue.append(request)
	if !is_spawning:
		process_queue()

func process_queue():
	if is_spawning:
		return
	is_spawning = true
	while !spawn_queue.is_empty():
		var request = spawn_queue.pop_front()
		await spawn_request(request)
	is_spawning = false
	queue_finished.emit()

func spawn_request(request: SpawnRequest):
	for i in range(request.amount):
		spawn_enemy(request.enemy_scene)
		if request.interval > 0:
			await get_tree().create_timer(request.interval).timeout

func spawn_enemy(scene: PackedScene):
	var enemy = scene.instantiate()
	enemy.global_position = get_spawn_position()
	alive_enemies.append(enemy)
	enemy_container.add_child(enemy)
	enemy_spawned.emit(enemy)

func _on_wave_started(wave_index: int, wave: WaveData):
	for enemy_data in wave.enemies:
		enqueue(enemy_data)

func get_spawn_position() -> Vector2:
	var rect = camera_manager.get_world_rect()
	var spawn_right := false
	if should_spawn_forward():
		spawn_right = player.last_direction == Vector2.RIGHT
	else:
		spawn_right = player.last_direction == Vector2.LEFT
	var pos := Vector2()
	if spawn_right:
		pos.x = rect.end.x + spawn_margin
	else:
		pos.x = rect.position.x - spawn_margin
	pos.y = randf_range(
		rect.position.y,
		rect.end.y
	)
	if abs(pos.x - player.global_position.x) < min_spawn_distance:
		if spawn_right:
			pos.x = player.global_position.x + min_spawn_distance
		else:
			pos.x = player.global_position.x - min_spawn_distance
	return pos

func remove_alive_enemy(enemy: Enemy):
	alive_enemies.erase(enemy)

func get_alive_count() -> int:
	return alive_enemies.size()

func get_alive_enemies() -> Array[Enemy]:
	return alive_enemies

func should_spawn_forward() -> bool:
	return randf() < forward_spawn_chance
