extends BaseCharacter
class_name Enemy

@export_group("Combat")

@export var enemy_data: EnemyData

@onready var attack: EnemyAttack = $EnemyAttack
@onready var movement: EnemyMovement = $EnemyMovement
@onready var player = get_tree().get_first_node_in_group("player")

@onready var status: StatusComponent = $StatusComponent
@onready var resistance: ResistanceComponent = $ResistanceComponent

signal enemy_died(enemy)

enum State{
	CHASE,
	ATTACK,
	DEAD
}

var current_state := State.CHASE

var is_hit := false

func _ready():

	super()

	add_to_group("enemy")

	AIManager.instance.register_enemy(self)

	if enemy_data:

		if enemy_data.resistance_data:

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

	if global_position.distance_to(
	player.global_position
	) <= enemy_data.attack_range:
		current_state = State.ATTACK
		return

	movement.update(delta)

func attack_state(delta):
	attack.update(delta)

func _on_died():

	enemy_died.emit(self)

	is_dead = true

	current_state = State.DEAD
	set_physics_process(false)
	AIManager.instance.unregister_enemy(self)

	var p = get_tree().get_first_node_in_group("player")

	if p:
		p.level.add_exp(enemy_data.exp_reward)

	animation.play_death()

	if animation.is_locked():
		await animation.animation_finished

	queue_free()
