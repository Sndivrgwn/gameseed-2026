extends Node

class_name CombatTypes

enum DamageType {
	PHYSICAL,
	MAGICAL,
	PURE,
	HEAL
}

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

enum HitType {
	HIT,
	CRITICAL,
	MISS,
	BLOCK
}

enum Team {
	PLAYER,
	ENEMY,
	NEUTRAL
}
