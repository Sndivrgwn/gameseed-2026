extends Node
class_name CombatCalculator

static func calculate_spell_damage(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
) -> DamageData:
	var result = DamageData.new()
	var damage = skill.damage
	damage += caster.stats.get_magic_attack()
	damage -= target.stats.get_magic_defense()
	damage = max(1, damage)
	result.amount = damage
	return result

static func calculate_physical_damage(
	caster_stats: StatsComponent,
	target_stats: StatsComponent
) -> DamageData:
	var result = DamageData.new()
	result.damage_type = DamageData.DamageType.PHYSICAL
	result.base_damage = caster_stats.get_attack()
	var damage = result.base_damage
	damage -= target_stats.get_defense()
	damage = max(1, damage)
	result.amount = damage
	return result
