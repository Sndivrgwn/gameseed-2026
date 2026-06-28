extends Area2D
class_name BaseProjectile

var caster: BaseCharacter
var skill_data: SkillData
var target : BaseCharacter

@export var speed := 500.0

func _ready():
	body_entered.connect(_on_body_entered)

	await get_tree().create_timer(skill_data.lifetime).timeout

	queue_free()

func _physics_process(delta):
	if !is_instance_valid(target):
		queue_free()
		return

	var direction = (
		target.global_position - global_position
	).normalized()
	global_position += direction * speed * delta
	if global_position.distance_to(
		target.global_position
	) < 10:
		hit_target()

func move(delta):
	position += Vector2.RIGHT * speed * delta

func _on_body_entered(body):
	pass

func can_hit(body) -> bool:
	if !(body is BaseCharacter):
		return false

	if body.team == caster.team:
		return false

	return true

func hit_target():
	var hit = CombatCalculator.calculate_spell_damage(
		caster,
		target,
		skill_data
	)
	target.take_damage(hit)
	queue_free()
