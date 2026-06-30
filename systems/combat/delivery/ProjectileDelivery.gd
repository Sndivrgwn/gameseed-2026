extends Node
class_name ProjectileDelivery

static func cast(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
):

	if skill.spell_scene == null:
		return

	var projectile: BaseProjectile = skill.spell_scene.instantiate()

	projectile.caster = caster
	projectile.target = target
	projectile.skill_data = skill

	caster.get_tree().current_scene.add_child(projectile)

	projectile.global_position = caster.get_cast_position()
