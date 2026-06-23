extends TextureProgressBar

func update_mana_smooth(new_value: float, duration: float = 0.5):
	var tween = create_tween()
	
	tween.tween_property(self, "value", new_value, duration)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
