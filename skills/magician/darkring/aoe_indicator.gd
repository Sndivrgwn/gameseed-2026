extends Node2D

var radius := 100.0

@export var fill_color := Color(0.4,0.0,1.0,0.15)
@export var outline_color := Color(0.6,0.2,1.0)
@export var outline_width := 3.0


func set_radius(value: float):

	radius = value
	queue_redraw()


func _draw():

	draw_circle(
		Vector2.ZERO,
		radius,
		fill_color
	)

	draw_arc(
		Vector2.ZERO,
		radius,
		0,
		TAU,
		64,
		outline_color,
		outline_width
	)
