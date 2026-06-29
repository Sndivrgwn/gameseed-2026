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
	DARK,
	NONE
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

enum TargetType {
	SELF,
	NEAREST_ENEMY,
}

enum DeliveryType {
	INSTANT,
	PROJECTILE,
	AREA
}

enum AreaShape {
	CIRCLE,
	RECTANGLE,
	CONE
}
