extends Resource
class_name LootTable

@export var item_loot: Array[LootEntry] = []
@export var currency_loot: Array[CurrencyLootEntry] = []

func roll() -> LootResult:
	print("roll")
	var result := LootResult.new()
	for entry in item_loot:

		if randf() * 100.0 > entry.chance:
			continue

		var item := ItemDatabase.get_item(entry.item_id)

		if item == null:
			continue

		var amount := randi_range(
			entry.min_amount,
			entry.max_amount
		)

		result.add_item(
			InventoryItem.new(
				item,
				amount
			)
		)

	for entry in currency_loot:

		if randf() * 100.0 > entry.chance:
			continue

		var amount := randi_range(
			entry.min_amount,
			entry.max_amount
		)

		result.add_currency(
			entry.currency_id,
			amount
		)
	
	print("Items:", result.items.size())
	print("Currencies:", result.currencies)
	return result
