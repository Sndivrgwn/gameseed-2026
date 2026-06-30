extends Node

func can_cast(
	caster: BaseCharacter,
	spell_name: StringName
) -> bool:

	if !is_instance_valid(caster):
		return false

	var skill := SkillDatabase.get_skill(spell_name)

	if skill == null:
		print("Skill not found :", spell_name)
		return false

	if caster.is_dead:
		return false

	if caster.is_casting:
		return false

	if caster.cooldowns == null:
		return false

	if caster.cooldowns.is_on_cooldown(skill.skill_name):
		return false

	if !skill.is_basic_attack:
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

	if skill == null:
		return false

	if !skill.is_basic_attack:

		if !caster.stats.spend_mana(skill.mana_cost):
			return false

	caster.is_casting = true

	if caster.has_method("show_cast_time"):
		caster.show_cast_time(skill.cast_time)

	if skill.cast_time > 0:

		await caster.get_tree().create_timer(
			skill.cast_time
		).timeout

	# caster mati saat casting
	if !is_instance_valid(caster):
		return false

	if caster.is_dead:
		return false

	caster.is_casting = false

	if caster.cooldowns:

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

	# target mati
	if !is_instance_valid(target):
		return false

	if target.is_dead:
		return false

	DeliveryManager.cast(
		caster,
		target,
		skill
	)

	return true
