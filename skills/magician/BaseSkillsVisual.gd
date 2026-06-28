extends Node2D
class_name BaseSkillVisual

var skill_data: SkillData

func _ready():
	print("base skill visual here")
	print("skill_data:", skill_data)

	if skill_data == null:
		print("skill_data masih null")
		return

	print("lifetime:", skill_data.lifetime)

	if skill_data.lifetime <= 0:
		print("lifetime <= 0")
		return

	get_tree().create_timer(skill_data.lifetime).timeout.connect(
		func():
			print("Timer selesai")
			if is_instance_valid(self):
				queue_free()
	)
