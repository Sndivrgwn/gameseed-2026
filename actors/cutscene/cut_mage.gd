extends CharacterBody2D

@onready var movement: MovementComponent = $MovementComponent
@onready var animation: AnimationComponent = $AnimationComponent
@export var speed = 250

var can_move = true

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	
	direction = direction.normalized()
	movement.move(direction)
	animation.handle_animation(direction)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print()
