extends MovementStrategy
class_name KeepDistanceMovement

@export_group("Distance")
@export var preferred_distance := 250.0
@export var retreat_distance := 120.0

@export_group("Movement")
@export var strafe_speed_multiplier := 0.45

func move(
	enemy: Enemy,
	movement: EnemyMovement,
	delta: float
) -> void:

	if !is_instance_valid(enemy.player):
		return

	# Knockback
	if enemy.is_hit:

		enemy.velocity = enemy.knockback_velocity

		enemy.move_and_slide()

		enemy.knockback_velocity = enemy.knockback_velocity.move_toward(
			Vector2.ZERO,
			enemy.knockback_friction * delta
		)

		if enemy.knockback_velocity.length() < 5:
			enemy.is_hit = false

		return

	var to_player = (
		enemy.player.global_position
		-
		enemy.global_position
	)

	var distance = to_player.length()

	var direction = to_player.normalized()

	var desired_velocity := Vector2.ZERO

	# Terlalu dekat → mundur
	if distance < retreat_distance:

		desired_velocity = (
			-direction
			*
			enemy.stats.get_speed()
		)

	# Terlalu jauh → maju
	elif distance > preferred_distance:

		desired_velocity = (
			direction
			*
			enemy.stats.get_speed()
		)

	# Jarak ideal → strafe
	else:

		var side = Vector2(
			-direction.y,
			direction.x
		)

		var wave = sin(Time.get_ticks_msec() * 0.003)

		desired_velocity = (
			side
			*
			wave
			*
			enemy.stats.get_speed()
			*
			strafe_speed_multiplier
		)

	desired_velocity += (
		movement.get_separation_force()
		*
		enemy.stats.get_speed()
	)

	enemy.velocity = enemy.velocity.move_toward(
		desired_velocity,
		movement.acceleration * delta
	)

	enemy.velocity += enemy.knockback_velocity

	enemy.move_and_slide()

	enemy.knockback_velocity = enemy.knockback_velocity.move_toward(
		Vector2.ZERO,
		enemy.knockback_friction * delta
	)

	enemy.update_animation(direction)
