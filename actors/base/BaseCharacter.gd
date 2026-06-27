extends CharacterBody2D
class_name BaseCharacter

@onready var stats: StatsComponent = $StatsComponent
@export var knockback_friction := 1200.0
enum Team {
	PLAYER,
	ENEMY
}

@export var team: Team

var knockback_velocity := Vector2.ZERO
var is_dead := false

func _ready():
	stats.died.connect(_on_died)

func take_damage(hit: HitResult):
	if is_dead:
		return
	stats.take_damage(hit)
	PopupManager.spawn_damage(
	hit,
	global_position
	)
	flash()
	#var direction = (
		#global_position - source_position
	#).normalized()
	#apply_knockback(direction,250)

func _on_died():
	is_dead = true
	queue_free()

func apply_knockback(direction, force):
	knockback_velocity = direction.normalized() * force

func flash():
	modulate = Color.RED
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE
