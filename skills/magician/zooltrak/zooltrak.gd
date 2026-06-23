extends Area2D

@export var speed := 500

func _process(delta):
	position += Vector2.RIGHT * speed * delta
