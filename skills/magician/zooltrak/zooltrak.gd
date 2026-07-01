extends BaseSkillVisual

@onready var anim: AnimatedSprite2D = $zooltrak
@onready var circle: AnimatedSprite2D = $circle


func initialize():

	await play_repeated_hits()

	queue_free()


func play_hit_animation():

	anim.play("strike")
	circle.play("circle_start")


func wait_until_hit():

	while anim.frame < 3:
		await get_tree().process_frame


func wait_until_animation_finished():
	circle.play("circle_end")
	await anim.animation_finished
