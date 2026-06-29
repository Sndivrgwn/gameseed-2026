extends Node
class_name CameraManager

@export_category("References")
@export var camera: Camera2D
@export var player: BaseCharacter

@export_category("Look Ahead")
@export var look_ahead_distance := 180.0
@export var look_speed := 6.0

var target_offset := Vector2.ZERO
var current_offset := Vector2.ZERO

var shake_strength := 0.0
var shake_duration := 0.0
var shake_timer := 0.0


func _process(delta):

	update_look_ahead(delta)
	update_camera_shake(delta)


func shake(strength: float, duration: float):

	if strength > shake_strength:
		shake_strength = strength

	shake_duration = duration
	shake_timer = duration


func get_camera() -> Camera2D:
	return camera


func get_center() -> Vector2:
	return camera.get_screen_center_position()


func get_world_rect() -> Rect2:

	var viewport_size = get_viewport().get_visible_rect().size

	var world_size = viewport_size * camera.zoom

	var top_left = camera.get_screen_center_position() - world_size / 2.0

	return Rect2(top_left, world_size)


func is_visible(world_position: Vector2) -> bool:
	return get_world_rect().has_point(world_position)


func update_look_ahead(delta):

	if player == null:
		return

	target_offset.x = player.get_facing_direction() * look_ahead_distance

	current_offset = current_offset.lerp(
		target_offset,
		look_speed * delta
	)



func update_camera_shake(delta):

	var shake_offset := Vector2.ZERO

	if shake_timer > 0:

		shake_timer -= delta

		var percent := shake_timer / shake_duration

		var strength := shake_strength * percent

		shake_offset = Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)

		if shake_timer <= 0:
			shake_strength = 0

	camera.offset = current_offset + shake_offset
