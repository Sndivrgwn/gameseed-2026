extends CharacterBody2D
@export var detection_range := 300.0
@export var attack_range := 40.0
@export var attack_cooldown := 1.0


@onready var player = get_tree().get_first_node_in_group("player")
@onready var stats: StatsComponent = $StatsComponent

var can_attack := true
enum State{
	IDLE,
	CHASE,
	ATTACK,
	DEAD
}

var current_state = State.IDLE

func _ready():
	print("hp: ", stats.hp)
	stats.died.connect(_on_died)
	
func take_damage(amount):
	stats.take_damage(amount)

func _on_died():
	queue_free()

func _physics_process(delta):
	match current_state:
		State.IDLE:
			idle_state()
		State.CHASE:
			chase_state()
		State.ATTACK:
			attack_state()

func idle_state():
	velocity = Vector2.ZERO
	if player == null:
		return
	if global_position.distance_to(player.global_position) <= detection_range:
		current_state = State.CHASE
	move_and_slide()

func chase_state():
	if player == null:
		return
	var distance = global_position.distance_to(player.global_position)
	if distance > detection_range:
		current_state = State.IDLE
		return
	if distance <= attack_range:
		current_state = State.ATTACK
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * stats.base_stats.move_speed
	move_and_slide()
	
func attack_state():
	if !can_attack:
		current_state = State.CHASE
		return
	can_attack = false
	if player.global_position.distance_to(global_position) <= attack_range:
		player.take_damage(stats.base_stats.attack)
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	current_state = State.CHASE

func update_animation(direction):
	pass
