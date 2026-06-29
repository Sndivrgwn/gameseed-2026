extends Resource
class_name SkillData

@export_category("Skill Definition")

@export_group("General Information")
@export var skill_name: String
@export var display_name: String
@export_multiline var description := ""
@export var spell_scene: PackedScene

@export_group("Combat Stats")
@export var mana_cost: int = 0
@export var damage: int = 0
@export var damage_type := CombatTypes.DamageType.MAGICAL
@export var element := CombatTypes.ElementType.NONE

@export_group("Timing")
@export var cast_time: float = 0.0
@export var lifetime: float = 0.0

@export_group("Targeting & Delivery")
@export var target_type := CombatTypes.TargetType.NEAREST_ENEMY
@export var delivery_type := CombatTypes.DeliveryType.PROJECTILE

@export_group("Area of Effect")
@export var area_radius := 128.0
@export var area_shape := CombatTypes.AreaShape.CIRCLE
@export var show_area_indicator := false

@export_group("Hit Mechanics")
@export var hit_count: int = 1
@export var hit_interval: float = 0.15

@export_group("Status Effects")
@export var apply_status_effect := false
@export var status_effect: StatusEffectData

@export_group("Impact")
@export var deal_damage := true
@export var apply_status := true

@export_group("Heal")
@export var heal_amount := 0

@export_group("Cooldown")
@export var cooldown : float = 0.0
