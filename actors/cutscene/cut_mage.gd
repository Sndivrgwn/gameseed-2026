extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var speed := 250

var can_move := true
var last_direction := "down"

func _physics_process(delta):

	if !can_move:
		anim.play("idle_down")
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction = Input.get_vector(
		"move_left",	
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed
	move_and_slide()

	handle_animation(direction)
	
func handle_animation(direction: Vector2):

	if direction == Vector2.ZERO:
		anim.play("idle_" + last_direction)
		return

	if abs(direction.x) > abs(direction.y):

		if direction.x > 0:
			last_direction = "right"
			anim.play("right")
		else:
			last_direction = "left"
			anim.play("left")

	else:

		if direction.y > 0:
			last_direction = "down"
			anim.play("down")
		else:
			last_direction = "up"
			anim.play("up")
