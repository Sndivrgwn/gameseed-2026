extends Node
class_name CombatCalculator


static func calculate_spell_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
) -> HitResult:

	var damage_data := DamageData.new()

	damage_data.base_damage = skill.damage
	damage_data.damage_type = skill.damage_type
	damage_data.element_type = skill.element
	damage_data.skill = skill
	damage_data.attacker = caster
	damage_data.target = target

	var hit := calculate_damage(
		caster,
		target,
		damage_data
	)

	if skill.apply_status_effect and hit.damage_data.amount > 0:
		var effect = skill.status_effect.effect_script.new()
		effect.data = skill.status_effect
		effect.source = caster
		target.status.add_effect(effect)
	return hit


static func calculate_basic_attack(
	caster: BaseCharacter,
	target: BaseCharacter
) -> HitResult:

	var damage_data := DamageData.new()

	damage_data.base_damage = caster.stats.get_attack()
	damage_data.damage_type = CombatTypes.DamageType.PHYSICAL
	damage_data.attacker = caster
	damage_data.target = target

	return calculate_damage(caster, target, damage_data)


static func calculate_effect_damage(
	source: BaseCharacter,
	target: BaseCharacter,
	base_damage: int,
	damage_type: CombatTypes.DamageType,
	element: CombatTypes.ElementType
) -> HitResult:

	var damage_data := DamageData.new()

	damage_data.base_damage = base_damage
	damage_data.damage_type = damage_type
	damage_data.element_type = element
	damage_data.attacker = source
	damage_data.target = target

	return calculate_damage(source, target, damage_data)


static func calculate_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	damage_data: DamageData
) -> HitResult:

	var final_damage := float(damage_data.base_damage)

	match damage_data.damage_type:

		CombatTypes.DamageType.PHYSICAL:
			final_damage -= target.stats.get_defense()

		CombatTypes.DamageType.MAGICAL:
			final_damage += caster.stats.get_magic_attack()
			final_damage -= target.stats.get_magic_defense()

		CombatTypes.DamageType.PURE:
			pass

		CombatTypes.DamageType.HEAL:
			final_damage += caster.stats.get_magic_attack()

	if damage_data.damage_type != CombatTypes.DamageType.HEAL:
		final_damage = apply_resistance(
			final_damage,
			target,
			damage_data.element_type
		)
	# Critical
	var is_critical := false
	if damage_data.damage_type != CombatTypes.DamageType.HEAL:
		is_critical = randf() < caster.stats.get_critical_rate()
		if is_critical:
			final_damage *= caster.stats.get_critical_multiplier()
	if damage_data.damage_type != CombatTypes.DamageType.HEAL:
		final_damage = max(0.0, final_damage)
	damage_data.amount = int(round(final_damage))
	damage_data.is_critical = is_critical
	var hit := HitResult.new()
	hit.damage_data = damage_data
	if is_critical:
		hit.result_type = HitResult.ResultType.CRITICAL
	else:
		hit.result_type = HitResult.ResultType.HIT

	return hit


static func apply_resistance(
	damage: float,
	target: BaseCharacter,
	element: CombatTypes.ElementType
) -> float:

	if element == CombatTypes.ElementType.NONE:
		return damage

	var resistance = target.resistance.get_resistance(element) 

	if resistance >= 1.0:
		return 0.0

	return damage * (1.0 - resistance)
