extends CanvasLayer

@onready var hp: Label = $stats/hp
@onready var mana: Label = $stats/mana
@onready var def: Label = $stats/def
@onready var attack: Label = $stats/attack
@onready var magic_attack: Label = $stats/magic_attack
@onready var magic_def: Label = $stats/magic_def
@onready var speed: Label = $stats/speed

func setup(player):
	var stats = player.stats

	print(stats.hp)
	print(stats.mana)
	hp.text = str("hp: ", stats.hp)
	mana.text = str("mana: ", stats.mana)
	def.text = str("def: ", stats.get_defense())
	attack.text = str("atk: ", stats.get_attack())
	magic_attack.text = str("m_atk: ", stats.get_magic_attack())
	magic_def.text = str("m_def: ", stats.get_magic_defense())
	speed.text = str("spd: ", stats.get_speed())

	stats.hp_changed.connect(_on_hp_changed)
	stats.mana_changed.connect(_on_mana_changed)

func _on_hp_changed(current_hp):
	hp.text = str(current_hp)

func _on_mana_changed(current_mana):
	mana.text = str(current_mana)
