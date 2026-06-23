extends Area2D

var speed = 500

func _process(delta):
	position.x += speed * delta
