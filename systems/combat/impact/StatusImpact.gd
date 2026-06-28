extends Node
class_name StatusImpact


static func execute(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	if skill.status_effect == null:
		return

	var effect = skill.status_effect.effect_script.new()

	effect.data = skill.status_effect

	effect.source = caster

	target.status.add_effect(effect)
