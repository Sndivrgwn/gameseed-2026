extends CharacterBody2D

@onready var spell_input: LineEdit = $"../CanvasLayer/SpellInput"
@export var speed = 200
@onready var anim = $AnimatedSprite2D
enum State {
	NORMAL,
	SPELL_INPUT
}
var spells = {
	"fireball": "fireball",
	"icebolt": "icebolt",
	"heal": "heal"
}
var current_state = State.NORMAL
var fireball_scene = preload("res://skills/magician/fireball/fireball.tscn")

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if current_state == State.NORMAL:
		direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	handle_animation(direction)

func handle_animation(direction):
	if direction.y < 0:
		anim.play("magician_up")
	elif direction.y > 0:
		anim.play("magician_down")
	elif  direction.x < 0:
		anim.play("magician_left")
	elif direction.x > 0:
		anim.play("magician_right")

func _input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed("state_magic"):
			if current_state == State.NORMAL:
				current_state = State.SPELL_INPUT
				
				spell_input.visible = true
				spell_input.grab_focus()
				print("Spell mode active")
			else:
				current_state = State.NORMAL
				
				spell_input.visible = false
				print("Spell mode not active")
		
		if current_state == State.SPELL_INPUT:
			if Input.is_action_pressed("cast_magic"):
				cast_spell()

func fireball():
	var fb = fireball_scene.instantiate()

	get_parent().add_child(fb)

	fb.global_position = global_position

func cast_spell():
	var spell_name = spell_input.text.to_lower()
	
	match spell_name:
		"fireball":
			fireball()
		_:
			print("skill tidak ditemukan")
	
	spell_input.text = ""
	spell_input.visible = false
	current_state = State.NORMAL
