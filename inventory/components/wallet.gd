extends Node
class_name Wallet

signal currency_changed(currency_id, amount)

var currencies: Dictionary = {}


func add(id: StringName, amount: int):

	if amount <= 0:
		return

	currencies[id] = currencies.get(id, 0) + amount

	currency_changed.emit(
		id,
		currencies[id]
	)


func remove(
	id: StringName,
	amount: int
) -> bool:

	if get_amount(id) < amount:
		return false

	currencies[id] -= amount

	if currencies[id] <= 0:
		currencies.erase(id)

	currency_changed.emit(
		id,
		get_amount(id)
	)

	return true


func get_amount(id: StringName) -> int:

	return currencies.get(id, 0)


func get_all() -> Dictionary:

	return currencies
