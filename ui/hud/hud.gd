extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $Margin_PlayerHud/VBox_HudLayout/HBox_ProfileLayout/VBox_StatusBar/VBox_BarLayout/Margin_HealthLayout/Texture_HealthProgres
@onready var mana_bar: TextureProgressBar = $Margin_PlayerHud/VBox_HudLayout/HBox_ProfileLayout/VBox_StatusBar/VBox_BarLayout/Margin_ManaLayout/Texture_ManaProgres
@onready var casting_bar: ProgressBar = $Margin_PlayerHud/VBoxContainer/CastingBar
@onready var level_ui: Label = $Margin_PlayerHud/VBox_HudLayout/MarginContainer/Nine_ExpBar/Label_LevelDisplay
@onready var exp: Label = $Margin_PlayerHud/VBox_HudLayout/MarginContainer/Nine_ExpBar/HBox_ExpLayout/Label_ExpDisplay
@onready var to_next: Label = $Margin_PlayerHud/VBox_HudLayout/MarginContainer/Nine_ExpBar/HBox_ExpLayout/Label_ExpDisplay2
@onready var label_health_display: Label = $Margin_PlayerHud/VBox_HudLayout/HBox_ProfileLayout/VBox_StatusBar/VBox_BarLayout/Margin_HealthLayout/Label_HealthDisplay
@onready var label_mana_display: Label = $Margin_PlayerHud/VBox_HudLayout/HBox_ProfileLayout/VBox_StatusBar/VBox_BarLayout/Margin_ManaLayout/Label_ManaDisplay
@onready var texture_exp_progress: TextureProgressBar = $Margin_PlayerHud/VBox_HudLayout/MarginContainer/MarginContainer/Texture_ExpProgress

var cast_tween: Tween

func setup(player: Node) -> void:
	var stats = player.stats
	var level = player.level

	# 1. Initialize Max Values
	hp_bar.max_value = stats.base_stats.max_hp
	mana_bar.max_value = stats.base_stats.max_mana

	# 2. Initialize Current Progress Bar Values
	hp_bar.value = stats.hp
	mana_bar.value = stats.mana

	# 3. Initialize Labels Text
	_update_hp_label(stats.hp)
	_update_mana_label(stats.mana)

	# 4. FIX: Initialize EXP Bar & Text pas awal game biar ga nge-blank
# 4. FIX: Initialize EXP Bar & Text pas awal game biar ga nge-blank
	level_ui.text = str("LVL. ", level.level) # Ubah dari level.current_level ke level.level
	_update_exp_ui(level.current_exp, level.exp_to_next)
	
	
	# 5. Connect Signals
	stats.hp_changed.connect(_on_hp_changed)
	stats.mana_changed.connect(_on_mana_changed)
	level.level_changed.connect(_on_level_changed)
	level.exp_changed.connect(_on_exp_changed)

func _on_exp_changed(current_exp: int, exp_to_next: int) -> void:
	_update_exp_ui(current_exp, exp_to_next)

func _on_level_changed(new_level: int) -> void:
	level_ui.text = str("LVL. ", new_level)

func _on_hp_changed(current_hp: float) -> void:
	hp_bar.update_hp_smooth(current_hp)
	_update_hp_label(current_hp)

func _on_mana_changed(current_mana: float) -> void:
	mana_bar.update_mana_smooth(current_mana)
	_update_mana_label(current_mana)

# Helper function buat bungkus logika EXP (Lebih Clean & Reusable)
func _update_exp_ui(current_exp: int, exp_to_next: int) -> void:
	exp.text = str(current_exp)
	to_next.text = str(exp_to_next)
	
	# Update bar visual-nya di sini!
	texture_exp_progress.max_value = exp_to_next
	texture_exp_progress.value = current_exp

func _update_hp_label(current_hp: float) -> void:
	label_health_display.text = str(int(current_hp), " / ", int(hp_bar.max_value))

func _update_mana_label(current_mana: float) -> void:
	label_mana_display.text = str(int(current_mana), " / ", int(mana_bar.max_value))

func show_cast_bar(duration: float) -> void:
	if cast_tween and cast_tween.is_valid():
		cast_tween.kill()

	casting_bar.visible = true
	casting_bar.value = 0

	cast_tween = create_tween()
	cast_tween.tween_property(casting_bar, "value", 100, duration)

	await cast_tween.finished
	casting_bar.visible = false
