extends CanvasLayer
class_name EnemyIndicator
@export var spawn_manager: SpawnManager
@export var camera_manager: CameraManager
@export var player: BaseCharacter
@onready var left_arrow: TextureRect = $Control/LeftArrow
@onready var right_arrow: TextureRect = $Control/RightArrow

func _process(delta):
	left_arrow.visible = false
	right_arrow.visible = false
	for enemy in spawn_manager.get_alive_enemies():
		if !is_instance_valid(enemy):
			continue
		if camera_manager.is_visible(enemy.global_position):
			continue
		if enemy.global_position.x < player.global_position.x:
			left_arrow.visible = true
			
		else:
			right_arrow.visible = true
