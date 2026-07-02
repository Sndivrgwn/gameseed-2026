extends RefCounted
class_name InventoryItem

var item: BaseItem
var amount: int

# Data unik (untuk equipment nanti)
var durability: int = 100
var upgrade_level: int = 0
var custom_data: Dictionary = {}

func _init(p_item: BaseItem = null, p_amount: int = 1):
	item = p_item
	amount = p_amount


func is_stackable() -> bool:
	if item == null:
		return false

	return item.max_stack > 1


func can_stack_with(other: InventoryItem) -> bool:
	if other == null:
		return false

	if item == null:
		return false

	if other.item == null:
		return false

	return item.id == other.item.id


func is_full() -> bool:
	if item == null:
		return true

	return amount >= item.max_stack


func get_remaining_stack() -> int:
	if item == null:
		return 0

	return item.max_stack - amount
