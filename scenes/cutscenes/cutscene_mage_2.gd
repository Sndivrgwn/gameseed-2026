extends Node2D

@onready var Player = $Magician
@onready var king = $King

var offset := 300.0

func _ready():

	Player.can_move = false

	await Fade.fadeOut()

	await get_tree().process_frame

	if king.global_position.x > Player.global_position.x:
		king.move_to(Player.global_position + Vector2(offset, 0))
	else:
		king.move_to(Player.global_position - Vector2(offset, 0))

	await king.reached_target

	start_dialog()
	
func start_dialog():
	$King/AnimatedSprite2D.flip_h = king.global_position.x > Player.global_position.x

	await king.get_node("SpeechBubble").show_text(
	"Selamat datang, Penyihir."
)
	await king.get_node("SpeechBubble").show_text(
	"Kami memerlukan kekuatanmu!."
)
	await Player.get_node("SpeechBubble").show_text(
	"Yang Mulia."
)

	Player.can_move = true
