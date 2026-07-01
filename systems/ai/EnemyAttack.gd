extends Node
class_name EnemyAttack

@onready var enemy := get_parent() as Enemy

var is_attacking := false

func _ready():
	await get_parent().ready

	if enemy.animation:
		enemy.animation.attack_impact.connect(_on_attack_impact)

func attack():

	is_attacking = true

	var dir = (
		enemy.player.global_position
		- enemy.global_position
	).normalized()

	enemy.animation.play_attack(dir)

	await enemy.animation.animation_finished

	is_attacking = false

	if !is_instance_valid(enemy.player):
		return

	if enemy.global_position.distance_to(
		enemy.player.global_position
	) > enemy.enemy_data.attack_range:

		enemy.current_state = Enemy.State.CHASE

func _on_attack_impact():

	if !is_attacking:
		return

	if !is_instance_valid(enemy.player):
		return

	if enemy.player.is_dead:
		return

	if enemy.global_position.distance_to(
		enemy.player.global_position
	) > enemy.enemy_data.attack_range:

		return

	SpellManager.cast(
		enemy,
		enemy.enemy_data.attack_skill,
		enemy.player
	)
