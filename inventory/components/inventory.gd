extends Node
class_name Inventory

signal inventory_changed

@export var capacity: int = 20

var items: Array[InventoryItem] = []


func add_item(item_id: StringName, amount: int = 1) -> bool:

	if amount <= 0:
		return false

	var item := ItemDatabase.get_item(item_id)

	if item == null:
		push_warning("Item '%s' tidak ditemukan." % item_id)
		return false

	var inventory_item := InventoryItem.new(item, amount)

	return add_inventory_item(inventory_item)


func add_inventory_item(new_item: InventoryItem) -> bool:

	if new_item == null:
		return false

	if new_item.item == null:
		return false

	var remaining := new_item.amount

	# =========================
	# Stack ke item yang sudah ada
	# =========================

	if new_item.is_stackable():

		for item in items:

			if !item.can_stack_with(new_item):
				continue

			if item.is_full():
				continue

			var add_amount = min(
				item.get_remaining_stack(),
				remaining
			)

			item.amount += add_amount
			remaining -= add_amount

			if remaining <= 0:
				inventory_changed.emit()
				return true

	# =========================
	# Buat stack baru
	# =========================

	while remaining > 0:

		if items.size() >= capacity:
			inventory_changed.emit()
			return false

		var stack_size = min(
			new_item.item.max_stack,
			remaining
		)

		var copy := InventoryItem.new(
			new_item.item,
			stack_size
		)

		copy.durability = new_item.durability
		copy.upgrade_level = new_item.upgrade_level
		copy.custom_data = new_item.custom_data.duplicate(true)

		items.append(copy)

		remaining -= stack_size

	inventory_changed.emit()

	return true


func remove_item(item_id: StringName, amount: int = 1) -> bool:

	if amount <= 0:
		return false

	var remaining := amount

	for i in range(items.size() - 1, -1, -1):

		var item := items[i]

		if item.item.id != item_id:
			continue

		var remove_amount = min(
			item.amount,
			remaining
		)

		item.amount -= remove_amount
		remaining -= remove_amount

		if item.amount <= 0:
			items.remove_at(i)

		if remaining <= 0:
			inventory_changed.emit()
			return true

	inventory_changed.emit()

	return false


func has_item(
	item_id: StringName,
	amount: int = 1
) -> bool:

	return get_item_count(item_id) >= amount


func get_item_count(
	item_id: StringName
) -> int:

	var total := 0

	for item in items:

		if item.item.id == item_id:
			total += item.amount

	return total


func clear():

	items.clear()

	inventory_changed.emit()
