extends Node
class_name BeamDelivery

static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):
	var beam = skill.spell_scene.instantiate()

	beam.caster = caster
	beam.skill_data = skill
	beam.direction = Vector2(caster.get_facing_direction(), 0)	

	caster.get_tree().current_scene.add_child(beam)

	beam.global_position = caster.global_position
