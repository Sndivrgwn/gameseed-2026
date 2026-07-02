extends StatusEffect
class_name AttackBuffEffect

var modifier : StatModifier


func on_apply():
	var modifier := StatModifier.new()
	modifier.stat_type = StatModifierType.Type.ATTACK
	modifier.value = 10

	owner.stats.add_modifier(modifier)


func on_remove():

	owner.stats.remove_modifier(modifier)
