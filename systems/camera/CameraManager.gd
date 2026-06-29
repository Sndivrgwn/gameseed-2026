extends Node
class_name CameraManager

@export var camera: Camera2D

var shake_strength := 0.0
var shake_duration := 0.0
var shake_timer := 0.0

var original_offset := Vector2.ZERO

func _ready():
	print("camera manager ready")
	print(camera.offset)
	original_offset = camera.offset


func get_camera() -> Camera2D:
	return camera
	
func get_world_rect() -> Rect2:
	var viewport_size = get_viewport().get_visible_rect().size
	var world_size = viewport_size * camera.zoom
	var top_left = camera.get_screen_center_position() - world_size / 2.0
	return Rect2(
		top_left,
		world_size
	)

func _process(delta):
	if shake_timer <= 0:
		camera.offset = original_offset
		return
	shake_timer -= delta
	var intensity = shake_strength * (shake_timer / shake_duration)
	camera.offset = original_offset + Vector2(
		randf_range(-intensity, intensity),
		randf_range(-intensity, intensity)
	)
	if shake_timer <= 0:
		camera.offset = original_offset

func get_center() -> Vector2:
	return camera.get_screen_center_position()

func is_visible(world_position: Vector2) -> bool:
	return get_world_rect().has_point(world_position)

func shake(strength: float, duration: float):
	print("shaka shaka")
	if strength > shake_strength:
		shake_strength = strength
	shake_duration = duration
	shake_timer = duration
