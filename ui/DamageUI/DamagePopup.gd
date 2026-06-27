extends Node2D
class_name DamagePopup

@onready var label: Label = $Label

func setup(damage: DamageData):
	label.text = str(damage.amount)
	
	#if damage.is_critical:
		#pass
	## warna merah, font besar
#
	#elif damage.is_heal:
		#pass
	## warna hijau
#
	#elif damage.is_missed:
		#pass
	## tampilkan "MISS"
#
	#else:
		#pass
	# damage biasa

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
