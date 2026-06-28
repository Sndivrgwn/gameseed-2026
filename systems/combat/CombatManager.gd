extends Node
class_name CombatCalculator

static func calculate_spell_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
) -> HitResult:
	var damage = DamageData.new()
	damage.damage_type = skill.damage_type
	damage.base_damage = skill.damage
	damage.skill = skill
	damage.attacker = caster
	damage.target = target
	if skill.apply_status_effect:
		var effect = skill.status_effect.effect_script.new()
		effect.data = skill.status_effect
		effect.source = caster
		target.status.add_effect(effect)
	return calculate_damage(caster, target, damage)

static func calculate_basic_attack(
	caster: BaseCharacter,
	target: BaseCharacter
) -> HitResult:
	var damage = DamageData.new()
	damage.damage_type = CombatTypes.DamageType.PHYSICAL
	damage.base_damage = caster.stats.get_attack()
	damage.attacker = caster
	damage.target = target
	return calculate_damage(caster, target, damage)

static func calculate_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	damage_data: DamageData
) -> HitResult:
	var final_damage = damage_data.base_damage
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
	var is_critical := false
	if damage_data.damage_type != CombatTypes.DamageType.HEAL:
		is_critical = randf() < caster.stats.get_critical_rate()
		if is_critical:
			final_damage *= caster.stats.get_critical_multiplier()
		final_damage = max(1, final_damage)
	final_damage = int(round(final_damage))
	damage_data.amount = final_damage
	damage_data.is_critical = is_critical
	var hit = HitResult.new()
	hit.damage_data = damage_data
	if is_critical:
		hit.result_type = HitResult.ResultType.CRITICAL
	else:
		hit.result_type = HitResult.ResultType.HIT
	return hit

static func calculate_effect_damage(
	source: BaseCharacter,
	target: BaseCharacter,
	base_damage: int,
	damage_type: CombatTypes.DamageType,
	element: CombatTypes.ElementType
) -> HitResult:
	var damage_data = DamageData.new()
	damage_data.base_damage = base_damage
	damage_data.damage_type = damage_type
	damage_data.element_type = element
	damage_data.attacker = source
	damage_data.target = target
	return calculate_damage(source, target, damage_data)
