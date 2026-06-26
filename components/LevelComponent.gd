extends Node
class_name LevelComponent

signal exp_changed(current_exp, exp_to_next)
signal level_changed(level)

@export var level := 1
@export var current_exp := 0
@export var exp_to_next := 100

func add_exp(amount:int):
	current_exp += amount
	exp_changed.emit(current_exp, exp_to_next)
	check_level_up()

func check_level_up():
	while current_exp >= exp_to_next:
		current_exp -= exp_to_next
		level += 1
		level_changed.emit(level)
		exp_to_next = int(exp_to_next * 1.25)
