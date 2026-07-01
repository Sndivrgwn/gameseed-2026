extends Node
class_name MeleeDelivery

static func cast(
	caster: BaseCharacter,
	target,
	skill: SkillData
):

	var spell = skill.spell_scene.instantiate()

	spell.caster = caster
	spell.skill_data = skill

	caster.get_tree().current_scene.add_child(spell)

	spell.global_position = caster.get_cast_position()
