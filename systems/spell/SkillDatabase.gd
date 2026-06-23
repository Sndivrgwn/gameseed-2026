extends Node

var skills = {}

func _ready():
	load_skill(
		preload("res://resources/skills/fireball.tres")
	)
	
	load_skill(
		preload("res://resources/skills/zooltrak.tres")
	)

func load_skill(skill : SkillData):
	skills[skill.skill_name] = skill

func get_skill(skill_name : String):
	return skills.get(skill_name)
