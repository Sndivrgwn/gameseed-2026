extends CharacterBody2D

@export var move_speed := 100

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var target_position: Vector2
var moving := false


signal reached_target

func move_to(pos: Vector2):
	target_position = pos
	moving = true
	
func _physics_process(delta):

	if !moving:
		velocity = Vector2.ZERO
		anim.play("idle_down")
		return

	var direction = target_position - global_position

	if direction.length() < 10:
		moving = false
		velocity = Vector2.ZERO
		anim.play("idle")
		reached_target.emit()
		return

	velocity = direction.normalized() * move_speed
	anim.play("walk_left")

	move_and_slide()
