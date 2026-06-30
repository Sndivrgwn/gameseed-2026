extends BaseSkillVisual
class_name BaseProjectile

var target: BaseCharacter

var direction := Vector2.ZERO

func _ready():

	super._ready()

	if is_instance_valid(target):

		direction = (
			target.global_position
			-
			global_position
		).normalized()

func _physics_process(delta):

	if skill_data == null:
		queue_free()
		return

	# Homing
	if skill_data.homing:

		if !is_instance_valid(target):
			queue_free()
			return

		direction = (
			target.global_position
			-
			global_position
		).normalized()

	global_position += (
		direction
		*
		skill_data.projectile_speed
		*
		delta
	)

	if is_instance_valid(target):

		if global_position.distance_to(
			target.global_position
		) <= skill_data.hit_distance:

			hit_target()
	rotation = direction.angle() + PI / 2
func hit_target():

	if !is_instance_valid(target):
		queue_free()
		return

	HitExecutor.execute(
		caster,
		target,
		skill_data
	)

	queue_free()
