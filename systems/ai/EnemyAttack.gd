extends Node
class_name EnemyAttack

@onready var enemy := get_parent() as Enemy

var is_attacking := false

func update(delta: float) -> void:

	if enemy == null:
		return

	if !is_instance_valid(enemy.player):
		return

	enemy.velocity = enemy.velocity.move_toward(
		Vector2.ZERO,
		enemy.movement.deceleration * delta
	)

	enemy.move_and_slide()

	if is_attacking:
		return

	if enemy.global_position.distance_to(
		enemy.player.global_position
	) > enemy.enemy_data.attack_range:

		enemy.current_state = Enemy.State.CHASE
		return

	if !SpellManager.can_cast(
		enemy,
		enemy.enemy_data.attack_skill
	):
		return

	attack()


func attack():

	is_attacking = true
	var dir = (
		enemy.player.global_position
		- enemy.global_position
	).normalized()

	var success = await SpellManager.cast(
		enemy,
		enemy.enemy_data.attack_skill,
		enemy.player
	)

	if !success:
		is_attacking = false
		return

	is_attacking = false

	if !is_instance_valid(enemy.player):
		return

	if enemy.global_position.distance_to(
		enemy.player.global_position
	) > enemy.enemy_data.attack_range:

		enemy.current_state = Enemy.State.CHASE
