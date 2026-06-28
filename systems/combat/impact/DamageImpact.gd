extends Node
class_name DamageImpact


static func execute(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	var hit = CombatCalculator.calculate_spell_damage(
		caster,
		target,
		skill
	)

	target.take_damage(hit)
