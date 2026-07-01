@tool
extends BTAction


func _generate_name() -> String:
	return "Update Target"


func _tick(_delta: float) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	if !is_instance_valid(enemy.player):
		return FAILURE

	blackboard.set_var("target", enemy.player)

	var distance = enemy.global_position.distance_to(
		enemy.player.global_position
	)

	blackboard.set_var("distance", distance)

	return SUCCESS
