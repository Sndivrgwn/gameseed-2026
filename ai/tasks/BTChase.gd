@tool
extends BTAction


func _generate_name() -> String:
	return "Chase"


func _tick(delta: float) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	enemy.movement.update(delta)

	return SUCCESS
