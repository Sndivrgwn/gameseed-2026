extends Node
class_name AreaDelivery

static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):
	if skill.spell_scene:

		var visual: BaseSkillVisual = skill.spell_scene.instantiate()

		visual.caster = caster
		visual.skill_data = skill

		visual.global_position = target.global_position

		caster.get_tree().current_scene.add_child(visual)

		if visual.has_method("initialize"):
			visual.initialize()

		return

	var enemies = CombatQuery.get_enemies_in_radius(
		caster,
		target.global_position,
		skill.area_radius
	)

	for enemy in enemies:

		HitExecutor.execute(
			caster,
			enemy,
			skill
		)
