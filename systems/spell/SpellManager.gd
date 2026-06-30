extends Node

func can_cast(
	caster: BaseCharacter,
	spell_name: StringName
) -> bool:

	var skill: SkillData = SkillDatabase.get_skill(spell_name)
	
	if skill == null:
		return false

	if caster.is_casting:
		return false

	if caster.cooldowns.is_on_cooldown(skill.skill_name):
		return false

	if caster.stats.mana < skill.mana_cost:
		return false

	return true


func cast(
	caster: BaseCharacter,
	spell_name: StringName,
	target_override: BaseCharacter = null
) -> bool:

	if !can_cast(caster, spell_name):
		return false

	var skill: SkillData = SkillDatabase.get_skill(spell_name)

	# Spend mana
	caster.stats.spend_mana(skill.mana_cost)

	caster.is_casting = true

	if caster.has_method("show_cast_time"):
		caster.show_cast_time(skill.cast_time)

	if skill.cast_time > 0:

		await caster.get_tree().create_timer(
			skill.cast_time
		).timeout
	if !is_instance_valid(caster):
		return false
	caster.is_casting = false

	caster.cooldowns.start_cooldown(
		skill.skill_name,
		skill.cooldown
	)

	var target := target_override

	if target == null:

		target = TargetingManager.get_target(
			caster,
			skill.target_type
		)

	if target == null:
		return false

	DeliveryManager.cast(
		caster,
		target,
		skill
	)

	return true
