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

	if !caster.stats.spend_mana(skill.mana_cost):
		print("not enough mana")
		return

	caster.is_casting = true
	caster.show_cast_time(skill.cast_time)
	await caster.get_tree().create_timer(
		skill.cast_time
	).timeout
	caster.is_casting = false

	if skill.spell_scene:
		var spell = skill.spell_scene.instantiate()
		spell.skill_data = skill
		caster.get_tree().current_scene.add_child(spell)
		spell.global_position = caster.get_cast_position()
