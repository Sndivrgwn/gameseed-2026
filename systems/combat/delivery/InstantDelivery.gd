extends Node
class_name InstantDelivery

static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	HitExecutor.execute(
		caster,
		target,
		skill
	)

	if skill.spell_scene:

		var visual: BaseSkillVisual = skill.spell_scene.instantiate()

		visual.caster = caster
		visual.skill_data = skill

		caster.get_tree().current_scene.add_child(visual)

		visual.global_position = target.global_position
