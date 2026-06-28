extends Node
class_name HitExecutor

static func execute(
	caster: BaseCharacter,
	target: BaseCharacter,
	skill: SkillData
) -> void:
	for i in range(skill.hit_count):
		if !is_instance_valid(target):
			return
		if target.is_dead:
			return
		ImpactManager.execute(
			caster,
			target,
			skill
		)
		if i < skill.hit_count - 1:
			await caster.get_tree().create_timer(
				skill.hit_interval
			).timeout
