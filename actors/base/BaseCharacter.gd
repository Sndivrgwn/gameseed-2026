extends CharacterBody2D
class_name BaseCharacter

@onready var stats: StatsComponent = $StatsComponent
@export var knockback_friction := 1200.0
enum Team {
	PLAYER,
	ENEMY
}

@export var team: Team
@export var camera_manager: CameraManager
var knockback_velocity := Vector2.ZERO
var is_dead := false

func _ready():
	stats.died.connect(_on_died)

func take_damage(hit: HitResult):
	if is_dead:
		return
	match hit.damage_data.damage_type:
		CombatTypes.DamageType.HEAL:
			stats.heal(hit.damage_data.amount)
			return
	#print("Before:", stats.hp)
	stats.take_damage(hit)
	#print("After:", stats.hp)
	#print("stack:  ", self.status.get_stack(BurnEffect))
	PopupManager.spawn_damage(
		hit,
		global_position
	)
	print(team)
	print(camera_manager)
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
