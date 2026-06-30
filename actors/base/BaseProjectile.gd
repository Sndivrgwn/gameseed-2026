extends BaseSkillVisual
class_name BaseProjectile

var target : BaseCharacter

@export var speed := 500.0

func _ready():
	print("Projectile Spawn")
	
func _physics_process(delta):

	if !is_instance_valid(target):
		queue_free()
		return

	var direction = (
		target.global_position
		-
		global_position
	).normalized()

	global_position += direction * speed * delta

	if global_position.distance_to(
		target.global_position
	) <= 10:

		hit_target()

func move(delta):

	position += Vector2.RIGHT * speed * delta

func can_hit(body) -> bool:

	if !(body is BaseCharacter):
		return false

	if body.team == caster.team:
		return false

	return true

func _on_body_entered(body):
	pass

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
