extends Button

func _ready():
	text = "CLICK"

func _gui_input(event):
	if event is InputEventMouseButton:
		print("GUI")

func _pressed():
	print("PRESSED")
