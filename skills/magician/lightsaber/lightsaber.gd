extends BaseSkillVisual

@export var beam_length := 700.0

var direction := Vector2.RIGHT

var enemies : Array[BaseCharacter]

@onready var area := $Area2D
@onready var timer := $HitTimer


func _ready():

	super._ready()

	rotation = direction.angle()
	timer.wait_time = skill_data.hit_interval
	timer.start()


func _on_hit_timer_timeout():

	enemies = enemies.filter(func(enemy):
		return is_instance_valid(enemy) and !enemy.is_dead
	)
	for enemy in enemies:
		HitExecutor.execute(caster, enemy, skill_data)


func _on_area_2d_body_entered(body):
	if body is BaseCharacter:

		if body.team == caster.team:
			return

		if enemies.has(body):
			return

		enemies.append(body)


func _on_area_2d_body_exited(body):

	enemies.erase(body)
