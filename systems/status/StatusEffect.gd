extends RefCounted
class_name StatusEffect

var owner: BaseCharacter
var source: BaseCharacter

var data: StatusEffectData

var duration := 0.0
var elapsed := 0.0

var tick_timer := 0.0

var stacks := 1
var max_stacks := 1


func on_apply():
	pass


func on_tick():
	pass


func on_remove():
	pass


func on_update(delta):
	pass

func on_stack_added():
	pass

func update(delta):

	elapsed += delta
	tick_timer += delta

	on_update(delta)

	if data.tick_rate > 0:
		if tick_timer >= data.tick_rate:
			tick_timer = 0.0
			on_tick()
func is_finished() -> bool:
	return elapsed >= duration
