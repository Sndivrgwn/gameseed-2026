extends Node2D

@export var radius := 128

func _draw():
	draw_arc(
		Vector2.ZERO,
		radius,
		0,
		TAU,
		64,
		Color.RED,
		3
	)

func _ready():
	queue_redraw()

func set_radius(r):
	radius = r
