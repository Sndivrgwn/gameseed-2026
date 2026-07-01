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

	if play_first([
		"attack_" + facing,
		"attack"
	]):
		animation_locked = true

# =========================
# CAST
# =========================

func play_cast(direction: Vector2 = Vector2.ZERO):

	if direction != Vector2.ZERO:
		facing = get_direction(direction)

	state = AnimationState.CAST

	if play_first([
		"cast_" + facing,
		"cast"
	]):
		animation_locked = true

# =========================
# HIT
# =========================

func play_hit(direction: Vector2 = Vector2.ZERO):

	if direction != Vector2.ZERO:
		facing = get_direction(direction)

	state = AnimationState.HIT

	if play_first([
		"hit_" + facing,
		"hit"
	]):
		animation_locked = true

# =========================
# DEATH
# =========================

func play_death():

	state = AnimationState.DEAD

	if play_first([
		"death",
		"death_right"
	]):
		animation_locked = true

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

func play_first(list: Array) -> bool:

	if sprite == null:
		return false

	for anim in list:

		if sprite.sprite_frames.has_animation(anim):

			sprite.flip_h = false

			if sprite.animation == anim and sprite.is_playing():
				return true

			sprite.play(anim)
			return true

		if anim.ends_with("_left"):

			var right_anim = anim.replace("_left", "_right")

			if sprite.sprite_frames.has_animation(right_anim):

				sprite.flip_h = true

				if sprite.animation == right_anim and sprite.is_playing():
					return true

				sprite.play(right_anim)
				return true

	return false

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
