extends TextureProgressBar

var current_tween: Tween

func update_hp_smooth(new_value: float, duration: float = 0.5):
	if current_tween:
		current_tween.kill()
		
	var tween = create_tween()
	
	tween.tween_property(self, "value", new_value, duration)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
