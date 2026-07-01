extends BaseSkillVisual

@export var fall_speed := 900.0
@export var spawn_height := 700.0
var velocity := 0.0
@export var gravity := 2500.0

var target_position := Vector2.ZERO
var exploded := false

@onready var meteor := $meteor
@onready var explosion := $AnimatedSprite2D

func _ready():

	super._ready()

	target_position = global_position

	global_position.y -= spawn_height

	meteor.play("meteor")

	explosion.hide()


func _physics_process(delta):

	if exploded:
		return

	velocity += gravity * delta

	global_position.y += velocity * delta

	if global_position.y >= target_position.y:

		global_position = target_position

		explode()


func explode():

	exploded = true

	meteor.hide()

	explosion.show()

	explosion.play("meteor_explosion")

	impact()

	await explosion.animation_finished

	queue_free()
