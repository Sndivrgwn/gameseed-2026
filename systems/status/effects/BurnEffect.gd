extends StatusEffect
class_name BurnEffect

var damage_per_tick = 5

func on_apply():
	print(owner.name, " burned!")

func on_tick():
	damage_per_tick = owner.stats.get_max_hp() * 0.01
	if !is_instance_valid(owner):
		return
	if !is_instance_valid(source):
		var hit = HitResult.new()
		hit.damage_data = DamageData.new()
		hit.damage_data.amount = damage_per_tick
		hit.damage_data.damage_type = CombatTypes.DamageType.PURE
		hit.damage_data.element_type = CombatTypes.ElementType.FIRE

		owner.take_damage(hit)
		return
	var hit = CombatCalculator.calculate_effect_damage(
	source,
	owner,
	damage_per_tick,
	CombatTypes.DamageType.PURE,
	CombatTypes.ElementType.FIRE
	)
	owner.take_damage(hit)

func on_remove():
	print(owner.name, " burn end.")
