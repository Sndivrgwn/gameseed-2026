extends CanvasLayer

@onready var win := $Margin_StatusWindow
@onready var lbl := { 
	hp = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer2/HBox_StatsMaxHP/Label_StatsValue,
	mana = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer2/HBox_StatsMaxMana/Label_StatsValue,
	defense = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer2/HBox_StatsDefend/Label_StatsValue,
	attack = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer2/HBox_StatsAttack/Label_StatsValue,
	magic_attack = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer/HBox_StatsMagicAttack/Label_StatsValue,
	magic_defense = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer/HBox_StatsMagicDefend/Label_StatsValue,
	speed = $Margin_StatusWindow/Center_StatusWindowLayout/Margin_ContentLayout/Vbox_Content/VBoxContainer/HBox_Stats/VBoxContainer/HBox_StatsMaxHP8/Label_StatsValue

}
var _player: Node
var _was_paused := false

func _ready():
	win.visible = false

func _unhandled_input(event):
	if not (event is InputEventKey and event.pressed and not event.is_echo()):
		return
	
	var pause = get_node_or_null("../Pause")
	
	if event.keycode == KEY_E:
		if pause and pause.has_method("is_menu_visible") and pause.is_menu_visible():
			get_viewport().set_input_as_handled()
			return
		_toggle()
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed("ui_cancel") and win.visible:
		close()
		get_viewport().set_input_as_handled()

# --- Public ---
func setup(player: Node):
	if not is_instance_valid(player):
		push_error("StatusWindow: player null")
		return
	
	# Ambil stats dari player (fleksibel)
	var stats = null
	if player.has_method("get_stats"):
		stats = player.get_stats()
	elif "stats" in player:
		stats = player.stats
	else:
		push_error("StatusWindow: player tidak memiliki stats")
		return
	
	# Lepas sinyal lama
	if _player and _player != player:
		var old = _get_stats_from(_player)
		if old: _disconnect_stats(old)
	
	_player = player
	_update_stats(stats)
	_connect_stats(stats)

func is_window_visible() -> bool:
	return win.visible

func close():
	if win.visible:
		_set_visible(false)

# --- Private ---
func _toggle():
	_set_visible(not win.visible)

func _set_visible(vis: bool):
	win.visible = vis
	if vis:
		_was_paused = get_tree().paused
		get_tree().paused = true
	else:
		get_tree().paused = _was_paused

func _get_stats_from(node: Node):
	if node.has_method("get_stats"):
		return node.get_stats()
	elif "stats" in node:
		return node.stats
	return null

func _update_stats(stats):
	lbl.hp.text = str(stats.hp)
	lbl.mana.text = str(stats.mana)
	lbl.defense.text = str(stats.get_defense())
	lbl.attack.text = str(stats.get_attack())
	lbl.magic_attack.text = str(stats.get_magic_attack())
	lbl.magic_defense.text = str(stats.get_magic_defense())
	lbl.speed.text = str(stats.get_speed())

func _connect_stats(stats):
	if stats.has_signal("hp_changed") and not stats.hp_changed.is_connected(_on_hp_changed):
		stats.hp_changed.connect(_on_hp_changed)
	if stats.has_signal("mana_changed") and not stats.mana_changed.is_connected(_on_mana_changed):
		stats.mana_changed.connect(_on_mana_changed)

func _disconnect_stats(stats):
	if stats.has_signal("hp_changed") and stats.hp_changed.is_connected(_on_hp_changed):
		stats.hp_changed.disconnect(_on_hp_changed)
	if stats.has_signal("mana_changed") and stats.mana_changed.is_connected(_on_mana_changed):
		stats.mana_changed.disconnect(_on_mana_changed)

func _on_hp_changed(v): lbl.hp.text = str(v)
func _on_mana_changed(v): lbl.mana.text = str(v)

func _exit_tree():
	if _player:
		var s = _get_stats_from(_player)
		if s: _disconnect_stats(s)
