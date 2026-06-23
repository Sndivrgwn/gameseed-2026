extends Node

func cast(caster, spell_name):
	print("casting: ", spell_name)
	var skill = SkillDatabase.get_skill(spell_name)
	if caster.mana < skill.mana_cost:
		return
	caster.mana -= skill.mana_cost
	
	if skill == null:
		return

	if skill.spell_scene:
		await caster.get_tree().create_timer(
			skill.cast_time
		).timeout
		
		var spell = skill.spell_scene.instantiate()
		caster.get_tree().current_scene.add_child(spell)
		spell.global_position = caster.global_position
