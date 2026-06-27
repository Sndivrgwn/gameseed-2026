extends Area2D
class_name BaseProjectile

var caster: BaseCharacter
var skill_data: SkillData

@export var speed := 500.0

func _ready():
	body_entered.connect(_on_body_entered)

	await get_tree().create_timer(skill_data.lifetime).timeout

	queue_free()

func _process(delta):
	move(delta)

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
