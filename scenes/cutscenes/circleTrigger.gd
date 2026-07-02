extends Area2D

@onready var anim: AnimatedSprite2D = $magicCircle

var teleporting := false

func _ready():
	body_entered.connect(_on_body_entered)
	anim.visible = false

func _on_body_entered(body):

	if teleporting:
		return

	if !body.is_in_group("player"):
		return

	teleporting = true

	body.can_move = false

	anim.visible = true
	anim.play("circle_open")

	await anim.animation_finished
	await Fade.fadeIn()

	get_tree().change_scene_to_file("res://scenes/cutscenes/cutsceneMage2.tscn")
