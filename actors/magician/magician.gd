extends CharacterBody2D

@export var speed = 200
@onready var anim = $AnimatedSprite2D
@onready var spell_input: LineEdit = $"../SpellInputUi/SpellLineEdit"

enum State {
	NORMAL,
	SPELL_INPUT
}

var current_state = State.NORMAL
var mana := 100
var hp := 100

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if current_state == State.NORMAL:
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	handle_animation(direction)

func handle_animation(direction):
	if direction.y < 0:
		anim.play("magician_up")
	elif direction.y > 0:
		anim.play("magician_down")
	elif  direction.x < 0:
		anim.play("magician_left")
	elif direction.x > 0:
		anim.play("magician_right")

func enter_spell_mode():
	current_state = State.SPELL_INPUT
	print("enter spell mode")
	spell_input.visible = true
	spell_input.grab_focus()

func exit_spell_mode():
	current_state = State.NORMAL
	print("exit spell mode")
	spell_input.visible = false
	
func submit_spell():
	var spell_name = spell_input.text.to_lower()
	print("submit spellddd")
	SpellManager.cast(self, spell_name)
	spell_input.text = ""
	exit_spell_mode()



func _input(event):
	if event.is_action_pressed("state_magic"):
		if current_state == State.NORMAL:
			enter_spell_mode()
		else:
			exit_spell_mode()


func _on_spell_line_edit_text_submitted(new_text: String) -> void:
	submit_spell()
	print("mana left: ", mana)
