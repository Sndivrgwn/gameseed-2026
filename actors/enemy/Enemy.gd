extends BaseCharacter
class_name Enemy

@export_group("Combat")
@export var attack_range := 40.0
@export var attack_cooldown := 1.0

@export_group("Movement")
@export var acceleration := 900.0
@export var deceleration := 1200.0

@export var enemy_data: EnemyData

@onready var player = get_tree().get_first_node_in_group("player")
@onready var status: StatusComponent = $StatusComponent
@onready var resistance: ResistanceComponent = $ResistanceComponent

signal enemy_died(enemy)

enum State {
	CHASE,
	ATTACK,
	DEAD
}

var current_state = State.CHASE
var can_attack := true
var is_hit := false

func _ready():
	super()

	if enemy_data and enemy_data.resistance_data:
		resistance.load(enemy_data.resistance_data)


func _physics_process(delta):

	match current_state:

		State.CHASE:
			chase_state(delta)

		State.ATTACK:
			attack_state(delta)

		State.DEAD:
			pass


func chase_state(delta):

	if !is_instance_valid(player):
		return

	# Knockback
	if is_hit:

		velocity = knockback_velocity

		move_and_slide()

		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_friction * delta
		)

		if knockback_velocity.length() < 5:
			is_hit = false

		return

	var direction = (
		player.global_position - global_position
	).normalized()

	update_animation(direction)

	var distance = global_position.distance_to(
		player.global_position
	)

	if distance <= attack_range:
		current_state = State.ATTACK
		return

	var target_velocity = direction * stats.get_speed()

	velocity = velocity.move_toward(
		target_velocity,
		acceleration * delta
	)

	move_and_slide()

	knockback_velocity = knockback_velocity.move_toward(
		Vector2.ZERO,
		knockback_friction * delta
	)


func attack_state(delta):

	velocity = velocity.move_toward(
		Vector2.ZERO,
		deceleration * delta
	)

	move_and_slide()

	if !can_attack:
		if global_position.distance_to(player.global_position) > attack_range:
			current_state = State.CHASE
		return

	can_attack = false

	if is_instance_valid(player):

		if global_position.distance_to(player.global_position) <= attack_range:

			var hit = CombatCalculator.calculate_basic_attack(
				self,
				player
			)

			hit.damage_data.attacker = self
			hit.damage_data.target = player

			player.take_damage(hit)

	await get_tree().create_timer(attack_cooldown).timeout

	can_attack = true

	if !is_instance_valid(player):
		return

	if global_position.distance_to(player.global_position) > attack_range:
		current_state = State.CHASE


func _on_died():
	enemy_died.emit(self)
	is_dead = true
	current_state = State.DEAD
	var player = get_tree().get_first_node_in_group("player")

	if player:
		player.level.add_exp(enemy_data.exp_reward)

	queue_free()


func update_animation(direction):
	pass
