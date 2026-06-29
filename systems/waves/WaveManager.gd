extends Node
class_name WaveManager

signal wave_started(wave_index: int, wave_data: WaveData)
signal wave_finished(wave_index: int)
signal wave_timer_updated(time_left: float)
signal intermission_started
signal intermission_finished

@export var waves: Array[WaveData]
@export var intermission_time := 2.0
@export var spawn_manager : SpawnManager

var current_wave_index := -1
var current_wave: WaveData
var wave_timer := 0.0
var is_wave_running := false
var alive_enemy := 0

func _ready():
	spawn_manager.enemy_spawned.connect(
		_on_enemy_spawned
	)
	
	spawn_manager.queue_finished.connect(
	_on_spawn_finished
)

func _on_enemy_spawned(enemy):
	("Enemy Spawned Registered	")
	alive_enemy +=	 1
	print("Alive :", alive_enemy)
	enemy.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(enemy):
	alive_enemy -= 1
	print("enemy now: ", alive_enemy)
	if alive_enemy < 0:
		alive_enemy = 0
	if alive_enemy == 0:
		if wave_timer > 0:
			clear_wave()

func get_alive_enemy():
	return alive_enemy

func start():

	current_wave_index = -1

	start_next_wave()

func start_next_wave():
	current_wave_index += 1
	print("starting wave: ", current_wave_index)
	if current_wave_index >= waves.size():
		print("All waves finished.")
		return
	current_wave = waves[current_wave_index]
	wave_timer = current_wave.duration
	is_wave_running = true
	wave_started.emit(
		current_wave_index,
		current_wave
	)

func _process(delta):
	if !is_wave_running:
		return
	wave_timer -= delta
	wave_timer_updated.emit(
		max(wave_timer, 0)
	)
	if wave_timer <= 0:
		end_wave()

func end_wave():
	if !is_wave_running:
		return
	is_wave_running = false
	wave_finished.emit(current_wave_index)
	intermission_started.emit()
	await get_tree().create_timer(intermission_time).timeout
	intermission_finished.emit()
	start_next_wave()

func clear_wave():
	if !is_wave_running:
		return
	if wave_timer <= 0:
		return
	end_wave()

func _on_spawn_finished():
	print("Spawn selesai")
