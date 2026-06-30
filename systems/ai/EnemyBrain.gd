extends Node
class_name EnemyBrain

@onready var enemy := get_parent() as Enemy

func update(_delta: float) -> void:

	if enemy == null:
		return

	if enemy.current_state == Enemy.State.DEAD:
		return

	update_target()

	if enemy.current_target == null:
		return

	var distance := enemy.global_position.distance_to(
		enemy.current_target.global_position
	)

	if distance <= enemy.enemy_data.attack_range:
		enemy.current_state = Enemy.State.ATTACK
	else:
		enemy.current_state = Enemy.State.CHASE


func update_target():

	if is_instance_valid(enemy.current_target):
		if !enemy.current_target.is_dead:
			return

	enemy.current_target = TargetingManager.get_target(
		enemy,
		CombatTypes.TargetType.NEAREST_ENEMY
	)
