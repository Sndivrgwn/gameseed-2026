extends StatusEffect
class_name PoisonEffect

var damage_per_tick := 0

func on_apply():
	print(owner.name, " poisoned!")

func on_tick():

	if !is_instance_valid(owner):
		return

	damage_per_tick = owner.stats.get_max_hp() * 0.02

	if is_instance_valid(source):

		var hit = CombatCalculator.calculate_effect_damage(
			source,
			owner,
			damage_per_tick,
			CombatTypes.DamageType.PURE,
			CombatTypes.ElementType.DARK
		)

		owner.take_damage(hit)

	else:

		var hit = HitResult.new()
		hit.damage_data = DamageData.new()

		hit.damage_data.amount = int(damage_per_tick)
		hit.damage_data.damage_type = CombatTypes.DamageType.PURE
		hit.damage_data.element_type = CombatTypes.ElementType.DARK

		owner.take_damage(hit)

func on_remove():
	print(owner.name, " poison ended.")
