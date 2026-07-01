extends BaseSkillVisual

@export var pull_speed := 600.0
@export var arrive_distance := 8.0

var enemies: Array[BaseCharacter] = []

var pulling := false
var exploded := false

@onready var explosion: AnimatedSprite2D = $explosion
@onready var ring_animation: AnimatedSprite2D = $ring_animation

func _ready():
	super._ready()
	explosion.visible = false
	ring_animation.play("ring_play")
	explosion.animation_finished.connect(_on_explosion_finished)

func initialize():

	enemies = CombatQuery.get_enemies_in_radius(
		caster,
		global_position,
		skill_data.area_radius
	)

	if enemies.is_empty():
		queue_free()
		return

	pulling = true

func _physics_process(delta):

	if !pulling:
		return

	var all_arrived := true

	for enemy in enemies:

		if !is_instance_valid(enemy):
			continue

		enemy.global_position = enemy.global_position.move_toward(
			global_position,
			pull_speed * delta
		)

		if enemy.global_position.distance_to(global_position) > arrive_distance:
			all_arrived = false

	if all_arrived:
		explode()


func explode():

	if exploded:
		return


	exploded = true
	pulling = false

	ring_animation.stop()
	ring_animation.visible = false

	explosion.visible = true
	explosion.play("explode")

	impact()


func _on_explosion_finished():

	print("Explosion finished")

	queue_free()
