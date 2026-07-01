extends StatusEffect
class_name SlowEffect

var modifier: StatModifier

func on_apply():

	if owner.movement == null:
		return

	modifier = StatModifier.new(
		StatModifierType.Type.MOVE_SPEED,
		-1.5,
		modifier.ModifierMode.PERCENT
	)
	
	owner.stats.add_modifier(modifier)


func on_remove():

	if owner.movement == null:
		return
	
	owner.stats.remove_modifier(modifier)

	print(owner.name, " normal speed")
