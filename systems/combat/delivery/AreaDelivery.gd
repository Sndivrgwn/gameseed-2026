extends Node
class_name AreaDelivery


static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	var enemies = CombatQuery.get_enemies_in_radius(
		target.global_position,
		skill.area_radius
	)

	for enemy in enemies:

		HitExecutor.execute(caster,	enemy,	skill)

		if skill.status_effect != null:

			var effect = skill.status_effect.effect_script.new()

			effect.data = skill.status_effect
			effect.source = caster

			enemy.status.add_effect(effect)
	
	if skill.spell_scene != null:
		var visual = skill.spell_scene.instantiate()
		visual.skill_data = skill
		caster.get_tree().current_scene.add_child(visual)
		visual.global_position = target.global_position
