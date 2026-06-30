extends Area2D
class_name BaseProjectile

var caster: BaseCharacter
var target: BaseCharacter
var skill_data: SkillData
var hit_targets : Array[BaseCharacter] = []
var direction := Vector2.ZERO

var hit_count := 0

func _ready():

	if skill_data == null:
		queue_free()
		return

	if is_instance_valid(target):

		direction = (
			target.global_position
			-
			global_position
		).normalized()

	body_entered.connect(_on_body_entered)

	start_lifetime()


func _physics_process(delta):

	if skill_data.homing:

		if is_instance_valid(target):

			direction = (
				target.global_position
				-
				global_position
			).normalized()

	position += (
		direction
		*
		skill_data.projectile_speed
		*
		delta
	)

	rotation = direction.angle()


func start_lifetime():

	if skill_data.lifetime <= 0:
		return

	await get_tree().create_timer(
		skill_data.lifetime
	).timeout

	if is_instance_valid(self):
		queue_free()


func _on_body_entered(body):

	if !can_hit(body):
		return

	if body in hit_targets:
		return

	hit_targets.append(body)

	HitExecutor.execute(
		caster,
		body,
		skill_data
	)

	hit_count += 1

	if skill_data.destroy_on_hit:
		queue_free()
		return

	if hit_count > skill_data.pierce_count:
		queue_free()


func can_hit(body) -> bool:
	if !is_instance_valid(body):
		return false

	if !(body is BaseCharacter):
		return false

	if !is_instance_valid(caster):
		return false

	if body.team == caster.team:
		return false

	return true
