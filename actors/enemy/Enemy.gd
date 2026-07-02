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
	print("Enemy died")
	print(enemy_data)
	print(enemy_data.loot_table)
	if enemy_data.loot_table:
		var loot := enemy_data.loot_table.roll()
		var player := get_tree().get_first_node_in_group("player")
		if player:
			for id in loot.currencies.keys():
				player.wallet.add(
					id,
					loot.currencies[id]
				)
		for item in loot.items:
			print(get_parent().name)
			WorldItem.spawn(
				get_parent(),
				global_position,
				item
			)
	queue_free()
