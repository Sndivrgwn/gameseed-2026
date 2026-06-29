extends Node
class_name EnemyAttack

@onready var enemy := get_parent() as Enemy
@export var attack_strategy: AttackStrategy
var can_attack := true

func update(delta: float) -> void:

	if enemy == null:
		return

	if !is_instance_valid(enemy.player):
		return

	# Berhenti bergerak saat menyerang
	enemy.velocity = enemy.velocity.move_toward(
		Vector2.ZERO,
		enemy.movement.deceleration * delta
	)

	enemy.move_and_slide()

	if !can_attack:

		if enemy.global_position.distance_to(
			enemy.player.global_position
		) > enemy.attack_range:

			enemy.current_state = Enemy.State.CHASE

		return

	attack()


func attack():
	can_attack = false
	attack_strategy.perform_attack(enemy)
	await get_tree().create_timer(
		enemy.attack_cooldown
	).timeout
	can_attack = true
	if !is_instance_valid(enemy.player):
		return
	if enemy.global_position.distance_to(
		enemy.player.global_position
	) > enemy.attack_range:
		enemy.current_state = Enemy.State.CHASE
