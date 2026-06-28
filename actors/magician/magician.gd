extends BaseCharacter

@onready var anim = $AnimatedSprite2D
@onready var hud: CanvasLayer = $"../Hud"
@onready var stats_ui: CanvasLayer = $"../StatsUi"
@onready var movement: MovementComponent = $MovementComponent
@onready var animation: AnimationComponent = $AnimationComponent
@onready var spell_caster: SpellCasterComponent = $SpellCasterComponent
@onready var spell_input: LineEdit = $"../SpellInputUi/SpellLineEdit"
@onready var level: LevelComponent = $LevelComponent
@onready var status: StatusComponent = $StatusComponent

var last_direction = Vector2.RIGHT
var is_invincible := false
var is_casting := false

func _ready():
	hud.setup(self)
	stats_ui.setup(self)
	stats.died.connect(_on_died)
	level.level_changed.connect(_on_level_up)

func show_cast_time(duration)  :
	hud.show_cast_bar(duration)

	
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if can_move():
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	
	direction = direction.normalized()
	movement.move(direction)
	animation.handle_animation(direction)

func can_move() -> bool:
	return spell_caster.current_state == spell_caster.State.NORMAL and !is_casting

func submit_spell():
	var spell_name = spell_input.text.to_lower()
	print("submit spell")
	SpellManager.cast(self, spell_name)
	spell_input.text = ""
	spell_caster.exit_spell_mode(spell_input)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		level.add_exp(40)

	if event.is_action_pressed("state_magic"):
		if spell_caster.current_state == spell_caster.State.NORMAL:
			spell_caster.enter_spell_mode(spell_input)
		else:
			spell_caster.exit_spell_mode(spell_input)

func get_cast_position() -> Vector2:
	return global_position

func _on_spell_line_edit_text_submitted(new_text: String) -> void:
	submit_spell()
	print("mana left: ", stats.mana)

func _on_level_up(new_level):
	stats.base_stats.max_hp += 10
	stats.base_stats.max_mana += 5
	stats.base_stats.magic_attack += 3
	stats.base_stats.defense += 1
	print("LEVEL UP :", new_level)
	print(stats.base_stats.defense)

func _on_died():
	print("Player Mati")
	set_physics_process(false)
	set_process_input(false)
	velocity = Vector2.ZERO
