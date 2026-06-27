extends Node
class_name CombatCalculator

static func calculate_spell_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
) -> HitResult:
	var damage_data = DamageData.new()
	damage_data.base_damage = skill.damage
	var damage = damage_data.base_damage
	var is_critical = randf() < caster.stats.get_critical_rate()
	damage += caster.stats.get_magic_attack()
	damage -= target.stats.get_magic_defense()
	if is_critical:
		damage *= caster.stats.get_critical_multiplier()
	damage = max(1, damage)
	damage = int(round(damage))
	damage_data.amount = damage
	damage_data.is_critical = is_critical
	damage_data.attacker = caster
	damage_data.target = target
	damage_data.skill = skill

	var hit = HitResult.new()
	hit.damage_data = damage_data

	if is_critical:
		hit.result_type = HitResult.ResultType.CRITICAL
	else:
		hit.result_type = HitResult.ResultType.HIT
	return hit
	
static func calculate_physical_damage(
	caster: BaseCharacter,
	target: BaseCharacter
) -> HitResult:

	var damage_data = DamageData.new()

	damage_data.damage_type = DamageData.DamageType.PHYSICAL
	damage_data.base_damage = caster.stats.get_attack()

	var damage = damage_data.base_damage

	var is_critical = randf() < caster.stats.get_critical_rate()

	damage -= target.stats.get_defense()

	if is_critical:
		damage *= caster.stats.get_critical_multiplier()

	damage = max(1, damage)
	damage = int(round(damage))

	damage_data.amount = damage
	damage_data.is_critical = is_critical
	damage_data.attacker = caster
	damage_data.target = target

	var hit = HitResult.new()
	hit.damage_data = damage_data

	if is_critical:
		hit.result_type = HitResult.ResultType.CRITICAL
	else:
		hit.result_type = HitResult.ResultType.HIT

	return hit
