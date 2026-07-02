extends RefCounted
class_name LootResult

var items: Array[InventoryItem] = []

var currencies := {}

func add_item(item: InventoryItem):

	items.append(item)

func add_currency(id: StringName, amount: int):
	currencies[id] = (
		currencies.get(id, 0)
		+ amount
	)
