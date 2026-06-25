extends Area2D

var skill_data : SkillData
@onready var zooltrak: AnimatedSprite2D = $zooltrak
@onready var circle: AnimatedSprite2D = $circle

func _ready():
	print("display name: ",skill_data.display_name)
	print("damage: ", skill_data.damage)
	print("element: ", skill_data.element)
	cast()
	await get_tree().create_timer(skill_data.lifetime).timeout
	circle.stop()
	queue_free()
	
func cast():
	zooltrak.play("zooltrak")
	circle.play("circle_start")
