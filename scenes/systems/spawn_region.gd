extends Area2D
class_name SpawnRegion

@export var enabled := true

@onready var collision: CollisionShape2D = $CollisionShape2D


func get_random_position() -> Vector2:

	if collision.shape is RectangleShape2D:

		var rect := collision.shape as RectangleShape2D

		var size = rect.size

		return global_position + Vector2(
			randf_range(-size.x / 2, size.x / 2),
			randf_range(-size.y / 2, size.y / 2)
		)

	return global_position
