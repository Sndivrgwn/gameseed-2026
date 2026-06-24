extends Node2D

@onready var chunk1 = $Chunk1
@onready var chunk2 = $Chunk2

var chunk_width = 2000

func _process(delta):
	var player_x = get_parent().get_node("Magician").global_position.x

	if player_x > chunk1.global_position.x + chunk_width:
		chunk1.global_position.x = chunk2.global_position.x + chunk_width

	if player_x > chunk2.global_position.x + chunk_width:
		chunk2.global_position.x = chunk1.global_position.x + chunk_width
