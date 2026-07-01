@tool
extends BTAction


func _generate_name() -> String:
	return "Attack"


func _tick(_delta: float) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	if enemy.attack.is_attacking:
		return RUNNING

	enemy.attack.attack()

	return SUCCESS
