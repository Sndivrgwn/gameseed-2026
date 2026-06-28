class_name StatusComponent
extends Node

var active_effects : Array[StatusEffect] = []

func _process(delta):
	for effect in active_effects.duplicate():
		effect.update(delta)
		if effect.is_finished():
			remove_effect(effect)

func add_effect(effect: StatusEffect):
	effect.owner = get_parent()
	effect.duration = effect.data.duration
	effect.tick_rate = effect.data.tick_rate
	effect.max_stacks = effect.data.max_stacks
	active_effects.append(effect)
	effect.on_apply()

func remove_effect(effect):
	effect.on_remove()
	active_effects.erase(effect)
