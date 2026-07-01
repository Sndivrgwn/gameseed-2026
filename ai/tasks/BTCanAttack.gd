@tool
extends BTCondition


func _generate_name() -> String:
	return "Can Attack"


func _tick(_delta) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	if SpellManager.can_cast(
		enemy,
		enemy.enemy_data.attack_skill
	):
		return SUCCESS

	return FAILURE
