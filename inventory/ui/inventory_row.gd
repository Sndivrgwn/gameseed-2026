extends HBoxContainer
class_name InventoryRow

@onready var icon: TextureRect = $Icon
@onready var name_label: Label = $NameLabel
@onready var amount_label: Label = $AmountLabel


func setup(item: InventoryItem):
	print("here we go baby")
	if item == null:
		return

	if item.item == null:
		return

	icon.texture = item.item.icon

	name_label.text = item.item.item_name

	if item.amount > 1:
		amount_label.text = "x%d" % item.amount
	else:
		amount_label.text = ""
