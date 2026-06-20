extends CharacterBody2D

@export var speed = 200
@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	direction = direction.normalized()
	velocity = direction * speed
	print(direction)
	move_and_slide()
	handle_animation(direction)

func handle_animation(direction):
	if direction.y < 0:
		anim.play("magician_up")
	elif direction.y > 0:
		anim.play("magician_down")
	elif  direction.x < 0:
		anim.play("magician_left")
	elif direction.x > 0:
		anim.play("magician_right")
