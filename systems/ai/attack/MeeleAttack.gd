extends AttackStrategy
class_name MeleeAttack

func perform_attack(attacker: Enemy):

	if !is_instance_valid(attacker.player):
		return

	if attacker.global_position.distance_to(
		attacker.player.global_position
	) > attacker.attack_range:
		return

	var hit = CombatCalculator.calculate_basic_attack(
		attacker,
		attacker.player
	)

	attacker.player.take_damage(hit)
