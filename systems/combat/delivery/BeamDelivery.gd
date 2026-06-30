extends Node
class_name BeamDelivery

static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):
	print("beamDelivery")
	var beam = skill.spell_scene.instantiate()

	beam.caster = caster
	beam.skill_data = skill
	beam.direction = (
	target.global_position - caster.global_position
	).normalized()

	caster.get_tree().current_scene.add_child(beam)

	beam.global_position = caster.global_position
