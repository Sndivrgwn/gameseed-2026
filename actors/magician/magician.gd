extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var spell_input: LineEdit = $"../SpellInputUi/SpellLineEdit"
@onready var hud: CanvasLayer = $"../Hud"
@onready var magic_circle: AnimatedSprite2D = $MagicCircle
@onready var stats: StatsComponent = $StatsComponent
@onready var stats_ui: CanvasLayer = $"../StatsUi"

enum State {
	NORMAL,
	SPELL_INPUT
}

var current_state = State.NORMAL
var last_direction = Vector2.RIGHT
var is_casting := false

func _ready():
	hud.setup(self)
	stats_ui.setup(self)
	
func show_cast_time(duration)  :
	hud.show_cast_bar(duration)
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if current_state == State.NORMAL:
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	direction = direction.normalized()
	velocity = direction * stats.base_stats.move_speed
	move_and_slide()
	handle_animation(direction)

func handle_animation(direction):
	if direction != Vector2.ZERO:
		last_direction = direction

	if direction == Vector2.ZERO:
		if last_direction.y < 0:
			anim.play("magician_idle_up")
		elif last_direction.y > 0:
			anim.play("magician_idle_down")
		elif last_direction.x < 0:
			anim.play("magician_idle_left")
		elif last_direction.x > 0:
			anim.play("magician_idle_right")
	else:
		if direction.y < 0:
			anim.play("magician_up")
		elif direction.y > 0:
			anim.play("magician_down")
		elif direction.x < 0:
			anim.play("magician_left")
		elif direction.x > 0:
			anim.play("magician_right")

func enter_spell_mode():
	current_state = State.SPELL_INPUT
	print("enter spell mode")
	magic_circle.visible = true
	magic_circle.play("circle_start")
	spell_input.visible = true
	spell_input.grab_focus()

func exit_spell_mode():
	current_state = State.NORMAL
	magic_circle.play("circle_stop")
	print("exit spell mode")
	spell_input.visible = false
	await self.get_tree().create_timer(
			4
		).timeout
	magic_circle.visible = false
	
func submit_spell():
	var spell_name = spell_input.text.to_lower()
	print("submit spell")
	SpellManager.cast(self, spell_name)
	spell_input.text = ""
	exit_spell_mode()

func _input(event):
	if event.is_action_pressed("state_magic"):
		if current_state == State.NORMAL:
			enter_spell_mode()
		else:
			exit_spell_mode()

func get_cast_position() -> Vector2:
	return global_position

func _on_spell_line_edit_text_submitted(new_text: String) -> void:
	submit_spell()
	print("mana left: ", stats.mana)
