extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HpBar
@onready var mana_bar: TextureProgressBar = $MarginContainer/VBoxContainer/ManaBar
@onready var status_label: Label = $MarginContainer/VBoxContainer/StatusLabel
@onready var casting_bar: ProgressBar = $MarginContainer/VBoxContainer/CastingBar

func update_hp(current_hp, max_hp):
	hp_bar.max_value = max_hp
	hp_bar.update_hp_smooth(current_hp)

func update_mana(current_mana, max_mana):
	mana_bar.max_value = max_mana
	mana_bar.update_mana_smooth(current_mana)

func set_status(text):
	status_label.text = text

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
