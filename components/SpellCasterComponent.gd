extends Node
class_name SpellCasterComponent

@export var magic_circle: AnimatedSprite2D
@export var stats : StatsComponent
var hud

enum State {
	NORMAL,
	SPELL_INPUT
}

var current_state = State.NORMAL

func _ready():
	magic_circle.visible = false
	magic_circle.animation_finished.connect(_on_circle_animation_finished)

func enter_spell_mode(spell_input: LineEdit):
	current_state = State.SPELL_INPUT
	magic_circle.visible = true
	magic_circle.play("circle_start")
	spell_input.visible = true
	spell_input.grab_focus()

func exit_spell_mode(spell_input: LineEdit):
	current_state = State.NORMAL
	if magic_circle.visible:
		magic_circle.play("circle_stop")
	spell_input.visible = false
	
func _on_circle_animation_finished():
	match magic_circle.animation:
		"circle_start":
			magic_circle.play("circle_loop")

		"circle_stop":
			magic_circle.visible = false

func close_input(spell_input: LineEdit):
	current_state = State.NORMAL
	spell_input.visible = false
	
func stop_magic_circle():
	if magic_circle.visible:
		magic_circle.play("circle_stop")
