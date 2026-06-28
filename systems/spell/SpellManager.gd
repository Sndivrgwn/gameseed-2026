extends Node

func cast(caster, spell_name):
	print("casting: ", spell_name)
	var skill = SkillDatabase.get_skill(spell_name)
	if skill == null:
		print("Skill not found")
		return

	if caster.is_casting:
		print("still casting")
		return
	if caster.cooldowns.is_on_cooldown(skill.skill_name):
		print("Skill cooldown")
		return
	
	if !caster.stats.spend_mana(skill.mana_cost):
		print("not enough mana")
		return

	caster.is_casting = true
	caster.show_cast_time(skill.cast_time)
	await caster.get_tree().create_timer(
		skill.cast_time
	).timeout
	caster.is_casting = false
	caster.cooldowns.start_cooldown(
	skill.skill_name,
	skill.cooldown
	)
	if skill.spell_scene:
		var target = TargetingManager.get_target(caster, skill.target_type)
		if target == null:
			return
		print(target)
		print(skill.delivery_type)
		DeliveryManager.cast(
			caster,
			target,
			skill
		)
