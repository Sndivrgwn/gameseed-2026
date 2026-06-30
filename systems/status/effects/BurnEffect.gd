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
		owner.take_damage_direct(damage_per_tick)
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
