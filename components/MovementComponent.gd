extends Node
class_name MovementComponent

@export var character : CharacterBody2D
@export var stats : StatsComponent

func move(direction):
	character.velocity = direction * stats.base_stats.move_speed
	character.move_and_slide()
