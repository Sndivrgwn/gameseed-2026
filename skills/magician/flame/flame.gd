extends Area2D

var skill_data : SkillData


func _ready():
	print("display name: ",skill_data.display_name)
	print("damage: ", skill_data.damage)
	print("element: ", skill_data.element)
	await get_tree().create_timer(skill_data.lifetime).timeout
	queue_free()
