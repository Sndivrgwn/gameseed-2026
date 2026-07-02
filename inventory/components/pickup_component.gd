extends Node
class_name PickupComponent

@export var inventory: Inventory
@export var wallet: Wallet


func pickup_item(
	item: InventoryItem
) -> bool:

	if inventory == null:
		return false

	return inventory.add_inventory_item(item)


func pickup_currency(
	id: StringName,
	amount: int
):

	if wallet == null:
		return

	wallet.add(id, amount)
