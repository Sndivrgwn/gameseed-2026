extends Node
class_name DamageData

enum DamageType {
	PHYSICAL,
	MAGICAL,
	PURE
}

var attacker
var target
var skill : SkillData

var base_damage : int = 0
var amount : int = 0

var is_critical := false
var is_heal := false
var is_missed := false
var is_blocked := false

var damage_type := DamageType.MAGICAL
