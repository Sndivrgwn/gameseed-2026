extends BaseItem
class_name EquipmentItem

enum EquipmentSlot {
	WEAPON,
	HELMET,
	CHEST,
	GLOVES,
	BOOTS,
	RING,
	AMULET
}

@export var slot : EquipmentSlot

@export var modifiers : Array[StatModifier]
