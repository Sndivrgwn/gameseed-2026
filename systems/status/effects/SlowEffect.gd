extends StatusEffect
class_name SlowEffect

var modifier: StatModifier

func on_apply():

	if owner.movement == null:
		return

	var modifier := StatModifier.new()
	modifier.stat_type = StatModifierType.Type.MOVE_SPEED
	modifier.value = -1.5

	owner.stats.add_modifier(modifier)


func on_remove():

	if owner.movement == null:
		return
	
	owner.stats.remove_modifier(modifier)

	print(owner.name, " normal speed")
