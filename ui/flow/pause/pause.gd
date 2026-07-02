extends CanvasLayer

@onready var menu := $Margin_Pause
@onready var resume_btn := $Margin_Pause/Center_Pause/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Texture_Resume
@onready var restart_btn := $Margin_Pause/Center_Pause/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Texture_Restart
@onready var exit_btn := $Margin_Pause/Center_Pause/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Texture_Exit

func _ready():
	menu.visible = false
	resume_btn.pressed.connect(_on_resume)
	restart_btn.pressed.connect(_on_restart)
	exit_btn.pressed.connect(_on_exit)

func _unhandled_input(event):
	if not event.is_action_pressed("ui_cancel"): return
	var sw = get_node_or_null("../StatusWindow")
	if sw and sw.has_method("is_window_visible") and sw.is_window_visible():
		return  # biar status window yang handle ESC
	toggle()
	get_viewport().set_input_as_handled()

func toggle():
	var sw = get_node_or_null("../StatusWindow")
	if sw and sw.has_method("is_window_visible") and sw.is_window_visible():
		sw.close()
		return
	get_tree().paused = not get_tree().paused
	menu.visible = not menu.visible

func is_menu_visible() -> bool:
	return menu.visible

func _on_resume(): toggle()

func _on_restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_exit():
	get_tree().paused = false
	get_tree().quit()
