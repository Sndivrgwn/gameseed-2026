extends Node

const DAMAGE_POPUP_SCENE = preload(
	"res://ui/DamageUI/DamagePopup.tscn"
)

func spawn_damage(damage: DamageData, position: Vector2):
	var popup = DAMAGE_POPUP_SCENE.instantiate()
	var offset = Vector2(
	randf_range(-12, 12),
	randf_range(-8, 8)
	)	
	get_tree().current_scene.add_child(popup)
	popup.global_position = position + offset
	popup.setup(damage)
