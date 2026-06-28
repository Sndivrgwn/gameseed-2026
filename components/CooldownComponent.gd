extends Node
class_name CooldownComponent

var cooldowns : Dictionary = {}
signal cooldown_started(skill_name, duration)
signal cooldown_finished(skill_name)

func _process(delta):
	for key in cooldowns.keys():
		cooldowns[key] -= delta
		if cooldowns[key] <= 0:
			cooldowns.erase(key)

func is_on_cooldown(
	skill_name:String
)->bool:
	return cooldowns.has(skill_name)
	
func start_cooldown(
	skill_name:String,
	duration:float
):
	cooldowns[skill_name] = duration

func get_remaining(
	skill_name:String
)->float:
	if !cooldowns.has(skill_name):
		return 0
	return cooldowns[skill_name]
