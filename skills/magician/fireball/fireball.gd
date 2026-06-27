extends BaseProjectile

func _ready():
	super()

	print(skill_data.display_name)

func _on_body_entered(body):
	if !can_hit(body):
		return

	var damage = CombatCalculator.calculate_spell_damage(
		caster,
		body,
		skill_data
	)

	body.take_damage(damage)

	queue_free()
