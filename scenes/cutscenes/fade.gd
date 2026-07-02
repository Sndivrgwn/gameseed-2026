extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation = $"ColorRect/AnimationPlayer"

func _ready():
	visible = false
	animation.stop()
	color_rect.modulate.a = 0
	
func fadeIn():
	visible = true
	animation.play("fadeIn")
	await animation.animation_finished

func fadeOut():
	animation.play("fadeOut")
	await animation.animation_finished
	visible = false
