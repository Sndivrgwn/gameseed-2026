extends Node2D

@onready var panel = $Panel
@onready var label = $RichTextLabel

func show_text(text: String, duration := 3.0):

	label.text = text
	visible = true

	await get_tree().create_timer(duration).timeout

	visible = false
