extends Node2D
class_name BaseSkillVisual

const AREA_INDICATOR_SCENE = preload("res://scenes/effects/indicators/AreaIndicator.tscn")

var caster: BaseCharacter
var skill_data: SkillData
var aoe_indicator


func _ready():
	print(name, " skill_data =", skill_data)
	if skill_data == null:
		return

	if skill_data.show_area_indicator and skill_data:
		aoe_indicator = AREA_INDICATOR_SCENE.instantiate()
		add_child(aoe_indicator)
		aoe_indicator.set_radius(skill_data.area_radius)

	# timer lifetime

	if skill_data.lifetime <= 0:
		return

	get_tree().create_timer(skill_data.lifetime).timeout.connect(
		func():
			if is_instance_valid(self):
				queue_free()
	)

func deal_area_damage():

	var enemies = CombatQuery.get_enemies_in_radius(
		global_position,
		skill_data.area_radius
	)

	for enemy in enemies:

		if !is_instance_valid(enemy):
			continue

		HitExecutor.execute(
			caster,
			enemy,
			skill_data
		)
