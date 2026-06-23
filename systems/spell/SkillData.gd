extends Resource

class_name SkillData

enum ElementType {
	FIRE,
	ICE,
	LIGHTNING,
	WATER,
	WIND,
	EARTH,
	HOLY,
	DARK
}

@export var skill_name: String
@export var display_name: String
@export var mana_cost: int = 0
@export var damage: int = 0
@export var cast_time: float = 0
@export var element: ElementType
@export var spell_scene: PackedScene
