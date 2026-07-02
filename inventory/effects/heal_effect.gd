extends BaseItemEffect
class_name HealEffect

@export var heal_amount := 50

func use(
	user: BaseCharacter,
	item: InventoryItem
) -> bool:

	print("HealEffect")

	if user == null:
		print("user null")
		return false

	if user.stats == null:
		print("stats null")
		return false

	print("Current HP:", user.stats.hp)
	print("Max HP:", user.stats.get_max_hp())

	if user.stats.hp >= user.stats.get_max_hp():
		print("HP Full")
		return false

	user.stats.heal(heal_amount)

	print("After Heal:", user.stats.hp)

	return true
