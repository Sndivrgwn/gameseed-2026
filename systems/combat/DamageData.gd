extends Node
class_name DamageData

var attacker
var target
var skill : SkillData

var base_damage : int = 0
var amount : int = 0

var is_critical := false
var is_heal := false
var is_missed := false
var is_blocked := false
var element_type := CombatTypes.ElementType.FIRE
var damage_type := CombatTypes.DamageType.MAGICAL
