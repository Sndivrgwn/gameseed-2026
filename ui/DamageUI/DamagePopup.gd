extends Node2D
class_name DamagePopup

@onready var label: Label = $Label

func setup(hit: HitResult):
	match hit.result_type:
		HitResult.ResultType.HIT:
			label.text = str(hit.damage_data.amount)
		HitResult.ResultType.CRITICAL:
			label.text = str(hit.damage_data.amount)
			modulate = Color.RED
		HitResult.ResultType.HEAL:
			label.text = "+" + str(hit.damage_data.amount)
			modulate = Color.GREEN
		HitResult.ResultType.MISS:
			label.text = "MISS"
		HitResult.ResultType.IMMUNE:
			label.text = "IMMUNE"

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
