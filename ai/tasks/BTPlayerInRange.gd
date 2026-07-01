@tool
extends BTCondition


func _generate_name() -> String:
	return "Player In Range"


func _tick(_delta: float) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	if !is_instance_valid(enemy.player):
		return FAILURE

	var distance = blackboard.get_var("distance")

	if distance <= enemy.enemy_data.attack_range:
		return SUCCESS

	return FAILURE
