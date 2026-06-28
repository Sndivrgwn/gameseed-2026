extends StatusEffect
class_name AttackBuffEffect

var modifier : StatModifier


func on_apply():
	modifier = StatModifier.new(
		StatModifierType.Type.ATTACK,
		20
	)
	owner.stats.add_modifier(modifier)


func on_remove():

	owner.stats.remove_modifier(modifier)
