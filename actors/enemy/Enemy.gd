extends BaseCharacter
class_name Enemy
@export var detection_range := 300.0
@export var attack_range := 40.0
@export var attack_cooldown := 1.0
@onready var player = get_tree().get_first_node_in_group("player")
@onready var status: StatusComponent = $StatusComponent
@onready var resistance: ResistanceComponent = $ResistanceComponent
@export var enemy_data: EnemyData
	
enum State {
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

var current_state = State.IDLE
signal enemy_died(enemy)
var can_attack := true
var is_hit := false

func _ready():
	super()
	if enemy_data.resistance_data:
		resistance.load(enemy_data.resistance_data)
	
	if enemy_data == null:
		return

func _physics_process(delta):
	match current_state:
		State.IDLE:
			idle_state(delta)
		State.CHASE:
			chase_state(delta)
		State.ATTACK:
			attack_state()
		State.DEAD:
			pass

func idle_state(delta):
	velocity = Vector2.ZERO
	move_and_slide()

	if player == null:
		return

	if global_position.distance_to(player.global_position) <= detection_range:
		current_state = State.CHASE

func chase_state(delta):
	if player == null:
		current_state = State.IDLE
		return
	if is_hit:
		velocity = knockback_velocity
		move_and_slide()
		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_friction * delta
		)
		return
	var distance = global_position.distance_to(player.global_position)
	if distance > detection_range:
		current_state = State.IDLE
		return
	if distance <= attack_range:
		current_state = State.ATTACK
		return
	var direction = (player.global_position - global_position).normalized()
	update_animation(direction)
	var move_velocity = direction * stats.get_speed()
	velocity = move_velocity + knockback_velocity
	move_and_slide()
	knockback_velocity = knockback_velocity.move_toward(
		Vector2.ZERO,
		knockback_friction * delta
	)

func attack_state():
	velocity = Vector2.ZERO
	move_and_slide()
	if !can_attack:
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
			#print("Enemy hp Before:", stats.hp)
			player.take_damage(hit)
			#print("Enemy hp After:", stats.hp)
			#print("stack", player.status.get_stack(BurnEffect))
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	if !is_instance_valid(player):
		current_state = State.IDLE
		return
	var distance = global_position.distance_to(player.global_position)
	if distance <= attack_range:
		current_state = State.ATTACK
	elif distance <= detection_range:
		current_state = State.CHASE
	else:
		current_state = State.IDLE

func _on_died():
	enemy_died.emit(self)
	is_dead = true
	current_state = State.DEAD
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.level.add_exp(enemy_data.exp_reward)
		print("LEVEL UP: ", )
	queue_free()

func update_animation(direction):
	pass
