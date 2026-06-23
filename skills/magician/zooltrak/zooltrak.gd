extends Area2D

var skill_data : SkillData

@export var speed := 0
@export var lifetime := 5

func _ready():
	print("display name: ",skill_data.display_name)
	print("damage: ", skill_data.damage)
	print("element: ", skill_data.element)
	await get_tree().create_timer(lifetime).timeout
	queue_free()
