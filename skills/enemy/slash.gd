extends BaseSkillVisual

func _ready():
	super._ready()
	play_repeated_hits()

func impact():
	var target = CombatQuery.get_enemy_in_range(
		caster,
		skill_data.area_radius
	)

	if target == null:
		return
	HitExecutor.execute(
		caster,
		target,
		skill_data
	)
