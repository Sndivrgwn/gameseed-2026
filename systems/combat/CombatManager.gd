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
