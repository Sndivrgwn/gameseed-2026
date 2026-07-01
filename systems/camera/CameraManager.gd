extends Node

@export var camera: Camera2D
@export var noise_emitter: PhantomCameraNoiseEmitter2D

func get_camera() -> Camera2D:
	return camera


func get_center() -> Vector2:
	return camera.get_screen_center_position()


func get_world_rect() -> Rect2:

	var viewport_size = get_viewport().get_visible_rect().size
	var world_size = viewport_size * camera.zoom
	var top_left = camera.get_screen_center_position() - world_size / 2

	return Rect2(top_left, world_size)


func is_visible(world_position: Vector2) -> bool:
	return get_world_rect().has_point(world_position)

func shake(
	strength: float = 10.0,
	duration: float = 0.15,
	frequency: float = 1.5
) -> void:
	print("shake callled")
	if noise_emitter == null:
		return

	noise_emitter.noise.amplitude = strength
	noise_emitter.noise.frequency = frequency

	noise_emitter.duration = duration
	noise_emitter.emit()
	print("Emitting:", noise_emitter.is_emitting())
func small_shake():
	shake(6, 0.08, 1.8)


func medium_shake():
	shake(12, 0.15, 1.5)


func big_shake():
	shake(22, 0.25, 1.2)


func boss_shake():
	shake(40, 0.45, 0.8)
