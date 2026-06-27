extends Node2D
class_name DamagePopup

@onready var label: Label = $Label

func setup(hit: HitResult):
	label.text = str(hit.damage_data.amount)

	if hit.is_critical():
		label.add_theme_font_size_override("font_size", 26)
		label.add_theme_color_override("font_color", Color.GOLD)
		scale = Vector2(1.4, 1.4)
	else:
		label.add_theme_font_size_override("font_size", 18)
		label.add_theme_color_override("font_color", Color.WHITE)

func _ready():
	var tween = create_tween()
	
	tween.parallel().tween_property(
		self,
		"position:y",
		position.y - 40,
		0.6
	)
	tween.parallel().tween_property(
		self,
		"modulate:a",
		0,
		0.6
	)
	await tween.finished
	queue_free()
