extends Node
class_name AnimationComponent

enum AnimationState {
	IDLE,
	WALK,
	ATTACK,
	CAST,
	HIT,
	DEAD
}

@export var sprite: AnimatedSprite2D

var state := AnimationState.IDLE
var facing := "down"

var animation_locked := false

signal animation_finished(state)

func _ready():

	if sprite == null:
		sprite = get_parent().get_node_or_null("AnimatedSprite2D")

	if sprite:
		sprite.animation_finished.connect(_on_animation_finished)

func update(direction: Vector2):

	if animation_locked:
		return

	if direction != Vector2.ZERO:
		play_walk(direction)
	else:
		play_idle()

# =========================
# WALK
# =========================

func play_walk(direction: Vector2):

	if animation_locked:
		return

	state = AnimationState.WALK

	facing = get_direction(direction)

	play_first([
		"walk_" + facing,
		"walk",
		"idle_" + facing,
		"idle"
	])

# =========================
# IDLE
# =========================

func play_idle():

	if animation_locked:
		return

	state = AnimationState.IDLE

	play_first([
		"idle_" + facing,
		"idle"
	])

# =========================
# ATTACK
# =========================

func play_attack(direction: Vector2 = Vector2.ZERO):

	if direction != Vector2.ZERO:
		facing = get_direction(direction)

	state = AnimationState.ATTACK

	animation_locked = true

	play_first([
		"attack_" + facing,
		"attack",
		"idle_" + facing,
		"idle"
	])

# =========================
# CAST
# =========================

func play_cast(direction: Vector2 = Vector2.ZERO):

	if direction != Vector2.ZERO:
		facing = get_direction(direction)

	state = AnimationState.CAST

	animation_locked = true

	play_first([
		"cast_" + facing,
		"cast",
		"idle_" + facing,
		"idle"
	])

# =========================
# HIT
# =========================

func play_hit(direction: Vector2 = Vector2.ZERO):

	if direction != Vector2.ZERO:
		facing = get_direction(direction)

	state = AnimationState.HIT

	animation_locked = true

	play_first([
		"hit_" + facing,
		"hit",
		"idle_" + facing,
		"idle"
	])

# =========================
# DEATH
# =========================

func play_death():

	state = AnimationState.DEAD

	animation_locked = true

	play_first([
		"death"
	])

# =========================
# INTERNAL
# =========================

func get_direction(direction: Vector2) -> String:

	if abs(direction.x) > abs(direction.y):

		if direction.x > 0:
			return "right"

		return "left"

	if direction.y > 0:
		return "down"

	return "up"

func play_first(list: Array):

	if sprite == null:
		return

	for anim in list:

		if sprite.sprite_frames.has_animation(anim):

			if sprite.animation == anim and sprite.is_playing():
				return

			sprite.play(anim)

			return

func _on_animation_finished():

	match state:

		AnimationState.ATTACK,\
		AnimationState.CAST,\
		AnimationState.HIT:

			animation_locked = false

			play_idle()

		AnimationState.DEAD:

			pass

	animation_finished.emit(state)

func apply_flip():
	if sprite == null:
		return
	sprite.flip_h = false
	match facing:
		"left":
			sprite.flip_h = true
		"right":
			sprite.flip_h = false

func is_locked() -> bool:
	return animation_locked

func get_facing() -> String:
	return facing

func unlock_animation():
	animation_locked = false
