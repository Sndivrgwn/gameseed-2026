extends Node
class_name HealImpact

static func execute(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	var damage_data = DamageData.new()
	damage_data.amount = skill.heal_amount

	var hit = HitResult.new()
	hit.damage_data = damage_data
	hit.result_type = HitResult.ResultType.HEAL

	target.stats.heal(skill.heal_amount)

	PopupManager.spawn_damage(
		hit,
		target.global_position
	)
