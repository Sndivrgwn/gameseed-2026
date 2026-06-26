extends Area2D

var skill_data : SkillData

@export var speed := 500

func _ready():
	print("display name: ",skill_data.display_name)
	print("damage: ", skill_data.damage)
	print("element: ", skill_data.element)
	
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(skill_data.lifetime).timeout
	queue_free()

func _process(delta):
	position += Vector2.RIGHT * speed * delta

func _on_body_entered(body):
	if !body.is_in_group("enemy"):
		return
	
	body.take_damage(skill_data.damage)
	
	print("Hit Enemy")
