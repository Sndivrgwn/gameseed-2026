extends MovementStrategy
class_name ChaseMovement

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

	var direction = (
		enemy.player.global_position
		-
		enemy.global_position
	).normalized()

	direction += movement.get_separation_force()

	direction = direction.normalized()

	enemy.animation.update(direction)

	var target_velocity = (
		direction
		*
		enemy.stats.get_speed()
	)

	enemy.velocity = enemy.velocity.move_toward(
		target_velocity,
		movement.acceleration * delta
	)

	enemy.velocity += enemy.knockback_velocity

	enemy.move_and_slide()

	enemy.knockback_velocity = enemy.knockback_velocity.move_toward(
		Vector2.ZERO,
		enemy.knockback_friction * delta
	)
