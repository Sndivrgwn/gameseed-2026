extends Area2D

var skill_data : SkillData

@export var speed := 500
@export var lifetime := 3

func _ready():
	print("display name: ",skill_data.display_name)
	print("damage: ", skill_data.damage)
	print("element: ", skill_data.element)
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	position += Vector2.RIGHT * speed * delta
