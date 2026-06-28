class_name StatusComponent
extends Node

var active_effects : Array[StatusEffect] = []

func _process(delta):
	for effect in active_effects.duplicate():
		effect.update(delta)
		if effect.is_finished():
			remove_effect(effect)

func add_effect(effect: StatusEffect):
	var existing = get_effect(
		effect.get_script()
	)
	print("Incoming:", effect.get_script())

	for e in active_effects:
		print("Existing:", e.get_script())
		
	if existing:
		if existing.stacks < existing.max_stacks:
			existing.stacks += 1
		existing.elapsed = 0
		existing.duration = effect.data.duration
		existing.on_stack_added()
		return

	effect.owner = get_parent()
	effect.duration = effect.data.duration
	effect.max_stacks = effect.data.max_stacks
	active_effects.append(effect)
	effect.on_apply()

func remove_effect(effect):
	effect.on_remove()
	active_effects.erase(effect)

func has_effect(effect_type: Script) -> bool:
	return get_effect(effect_type) != null

func get_effect(effect_type: Script) -> StatusEffect:
	for effect in active_effects:
		if effect.get_script() == effect_type:
			return effect
	return null

func refresh_effect(effect_type: Script) -> void:
	var effect = get_effect(effect_type)
	if effect:
		effect.duration = effect.data.duration
		
		# Optional: If your StatusEffect class has a specific refresh callback, 
		# you could call something like effect.on_refresh() here.

func get_stack(
	effect_type: Script
) -> int:
	var effect = get_effect(effect_type)
	if effect:
		return effect.stacks
	return 0

func remove_all_effects():
	for effect in active_effects.duplicate():
		remove_effect(effect)

func clear_negative_effects():
	for effect in active_effects.duplicate():
		if effect.data.is_negative:
			remove_effect(effect)
