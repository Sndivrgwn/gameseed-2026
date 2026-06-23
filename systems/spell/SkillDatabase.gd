extends Node

var skills := {}

func _ready():
	load_all_skills()

func load_skill(skill: SkillData):
	skills[skill.skill_name] = skill
	print("Loaded:", skill.skill_name)

func load_all_skills():
	var dir = DirAccess.open("res://resources/skills")
	if dir == null:
		push_error("Folder skill tidak ditemukan")
		return
	for file_name in dir.get_files():
		if file_name.ends_with(".tres"):
			var path = "res://resources/skills/" + file_name
			var skill = load(path)
			if skill:
				load_skill(skill)

func get_skill(skill_name : String):
	return skills.get(skill_name)
