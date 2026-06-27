extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HpBar
@onready var mana_bar: TextureProgressBar = $MarginContainer/VBoxContainer/ManaBar
@onready var casting_bar: ProgressBar = $MarginContainer/VBoxContainer/CastingBar
@onready var level_ui: Label = $MarginContainer/VBoxContainer/Level
@onready var exp: Label = $MarginContainer/VBoxContainer/Exp
@onready var to_next: Label = $MarginContainer/VBoxContainer/ToNext

func setup(player):
	var stats = player.stats
	var level = player.level

	hp_bar.max_value = stats.base_stats.max_hp
	mana_bar.max_value = stats.base_stats.max_mana

	hp_bar.value = stats.hp
	mana_bar.value = stats.mana

	stats.hp_changed.connect(_on_hp_changed)
	stats.mana_changed.connect(_on_mana_changed)
	level.level_changed.connect(_on_level_changed)
	level.exp_changed.connect(_on_exp_changed)

func _on_exp_changed(current_exp, exp_to_next):
	exp.text = str("exp: ", current_exp)
	to_next.text = str("to next level: " ,exp_to_next)
func _on_level_changed(level):
	level_ui.text = str("level: ", level)

func _on_hp_changed(current_hp):
	hp_bar.update_hp_smooth(current_hp)

func _on_mana_changed(current_mana):
	mana_bar.update_mana_smooth(current_mana)

func show_cast_bar(duration):
	casting_bar.visible = true
	casting_bar.value = 0

	var tween = create_tween()

	tween.tween_property(
		casting_bar,
		"value",
		100,
		duration
	)

	await tween.finished

	casting_bar.visible = false
