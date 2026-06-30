extends Node
class_name EnemyMovement

@onready var enemy := get_parent() as Enemy

@export_group("Movement")
@export var acceleration := 900.0
@export var deceleration := 1400.0

@export_group("Steering")
@export var separation_radius := 48.0
@export var separation_strength := 1.2
@export var personal_space := 16.0

func update(delta):

	if owner.enemy_data == null:
		return

	if owner.enemy_data.movement_strategy == null:
		return

	owner.enemy_data.movement_strategy.move(
		owner,
		self,
		delta
	)

func get_steering() -> Vector2:

	var steering := Vector2.ZERO

	steering += get_seek_force()

	steering += get_separation_force()

	if steering.length() == 0:
		return Vector2.ZERO

	return steering.normalized()


func get_seek_force() -> Vector2:

	return (
		enemy.player.global_position
		-
		enemy.global_position
	).normalized()


func get_separation_force() -> Vector2:

	var force := Vector2.ZERO

	var count := 0

	for other in AIManager.instance.get_alive_enemies():

		if other == enemy:
			continue

		if !is_instance_valid(other):
			continue

		var distance = enemy.global_position.distance_to(
			other.global_position
		)

		if distance > separation_radius:
			continue

		if distance < personal_space:
			distance = personal_space

		var push = (
			enemy.global_position
			-
			other.global_position
		).normalized()

		push /= distance * distance

		force += push

		count += 1

	if count == 0:
		return Vector2.ZERO

	force /= count

	if force.length() == 0:
		return Vector2.ZERO

	var weight = clamp(force.length(), 0.0, 1.0)

	return force.normalized() * weight * separation_strength
