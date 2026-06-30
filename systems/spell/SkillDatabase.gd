extends Node

var skills: Dictionary = {}

const SKILL_FOLDER := "res://resources/skills"


func _ready():
	load_all_skills()
	print("--------------------------------")
	print("Loaded Skills:")
	for key in skills.keys():
		print("-", key)
	print("--------------------------------")


func load_skill(skill: SkillData):

	if skill == null:
		return

	if skill.skill_name.is_empty():
		push_warning("Skill tanpa skill_name : " + skill.resource_path)
		return

	skills[skill.skill_name] = skill

	print("Loaded:", skill.skill_name)


func load_all_skills():

	skills.clear()

	load_folder(SKILL_FOLDER)


func load_folder(path: String):

	var dir := DirAccess.open(path)

	if dir == null:
		push_error("Folder tidak ditemukan : " + path)
		return

	dir.list_dir_begin()

	while true:

		var file_name := dir.get_next()

		if file_name == "":
			break

		if file_name.begins_with("."):
			continue

		var full_path := path + "/" + file_name

		if dir.current_is_dir():

			load_folder(full_path)

		elif file_name.ends_with(".tres"):

			var skill := load(full_path)

			if skill is SkillData:

				load_skill(skill)

	dir.list_dir_end()


func get_skill(skill_name: StringName) -> SkillData:

	return skills.get(skill_name, null)
