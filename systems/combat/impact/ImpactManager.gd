extends Node
class_name ImpactManager

static func execute(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	if skill.deal_damage:

		DamageImpact.execute(
			caster,
			target,
			skill
		)

	if skill.apply_status:

		StatusImpact.execute(
			caster,
			target,
			skill
		)

	if skill.heal_amount > 0:

		HealImpact.execute(
			caster,
			target,
			skill
		)
