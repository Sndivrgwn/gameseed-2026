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

func enter_spell_mode(spell_input: LineEdit):
	current_state = State.SPELL_INPUT
	print("enter spell mode")
	magic_circle.visible = true
	magic_circle.play("circle_start")
	spell_input.visible = true
	spell_input.grab_focus()

func exit_spell_mode(spell_input: LineEdit):
	current_state = State.NORMAL
	magic_circle.play("circle_stop")
	print("exit spell mode")
	spell_input.visible = false
	await self.get_tree().create_timer(
			4
		).timeout
	magic_circle.visible = false
	
