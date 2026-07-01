extends CharacterBody2D
class_name BaseCharacter

@export_group("Combat")
@export var basic_attack: SkillData
@export var knockback_friction := 1200.0
@export var team: Team
@export var camera_manager: CameraManager
@onready var stats: StatsComponent = $StatsComponent
@onready var animation: AnimationComponent = get_node_or_null("AnimationComponent")
@onready var cooldowns: CooldownComponent = get_node_or_null("CooldownComponent")
enum Team {
	PLAYER,
	ENEMY
}

var knockback_velocity := Vector2.ZERO
var is_dead := false
var is_casting := false

func _ready():
	add_to_group("character")
	stats.died.connect(_on_died)

func take_damage(hit: HitResult):
	if is_dead:
		return


	match hit.damage_data.damage_type:

		CombatTypes.DamageType.HEAL:
			stats.heal(hit.damage_data.amount)
			return

	stats.take_damage(hit)
	if is_dead:
		return
		
	if animation:
		animation.play_hit()

	PopupManager.spawn_damage(
		hit,
		global_position
	)

	if team == Team.PLAYER and camera_manager:
		camera_manager.shake(8,0.15)

	flash()

func _on_died():
	is_dead = true
	queue_free()

func apply_knockback(direction, force):
	knockback_velocity = direction.normalized() * force

func flash():
	modulate = Color.RED
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE

func get_cast_position() -> Vector2:
	return global_position
