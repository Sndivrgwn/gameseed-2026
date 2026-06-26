extends Node
class_name AnimationComponent

@export var anim: AnimatedSprite2D
var last_direction = Vector2.RIGHT

func handle_animation(direction):
	if direction != Vector2.ZERO:
		last_direction = direction

	if direction == Vector2.ZERO:
		if last_direction.y < 0:
			anim.play("idle_up")
		elif last_direction.y > 0:
			anim.play("idle_down")
		elif last_direction.x < 0:
			anim.play("idle_left")
		elif last_direction.x > 0:
			anim.play("idle_right")
	else:
		if direction.y < 0:
			anim.play("up")
		elif direction.y > 0:
			anim.play("down")
		elif direction.x < 0:
			anim.play("left")
		elif direction.x > 0:
			anim.play("right")
