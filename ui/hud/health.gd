extends TextureRect # Tetep pake TextureRect bray

var max_hp: float = 100.0
var current_hp: float = 100.0
var total_frames: int = 14

# Sesuai hitungan asset lo: 448px / 14 frame = 32px
@export var frame_height: float = 32.0 

func take_damage(amount: float) -> void:
	current_hp = clamp(current_hp - amount, 0.0, max_hp)
	update_hp_bar_visual()

func update_hp_bar_visual() -> void:
	var hp_percentage = current_hp / max_hp
	var frame_index = round((1.0 - hp_percentage) * (total_frames - 1))
	
	# JALUR AKSESNYA GINI:
	# Kita cek dulu apakah texture-nya emang pake AtlasTexture biar gak crash
	if texture is AtlasTexture:
		texture.region.position.y = frame_index * frame_height

# Tombol test pencet spasi
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		take_damage(10.0)
