extends Node2D
class_name BaseSkillVisual

const AREA_INDICATOR_SCENE = preload("res://scenes/effects/indicators/AreaIndicator.tscn")

var caster: BaseCharacter
var skill_data: SkillData
var aoe_indicator


func _ready():
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
	caster,
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

func play_repeated_hits() -> void:

	for i in range(skill_data.hit_count):

		play_hit_animation()

		await wait_until_hit()

		deal_area_damage()

		await wait_until_animation_finished()

		if i < skill_data.hit_count - 1:
			await get_tree().create_timer(
				skill_data.hit_interval
			).timeout

func play_hit_animation():
	pass


func wait_until_hit():
	pass


func wait_until_animation_finished():
	pass
