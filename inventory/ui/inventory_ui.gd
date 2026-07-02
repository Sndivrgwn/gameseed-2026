extends CanvasLayer
class_name InventoryUI

@export var player_path: NodePath

@onready var capacity_label: Label = $PanelContainer/MarginContainer/VBoxContainer/CapacityLabel
@onready var item_list: ItemList = $PanelContainer/MarginContainer/VBoxContainer/ItemList
@onready var currency_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/CurrencyList

var player
var inventory: Inventory
var wallet: Wallet


func _ready():

	visible = false
	await get_tree().process_frame
	if player_path.is_empty():
		player = get_tree().get_first_node_in_group("player")
	else:
		player = get_node(player_path)

	if player == null:
		push_error("InventoryUI: Player tidak ditemukan.")
		return

	inventory = player.inventory
	wallet = player.wallet

	inventory.inventory_changed.connect(_refresh_inventory)
	wallet.currency_changed.connect(_refresh_currency)

	item_list.item_clicked.connect(_on_item_clicked)

	_refresh_inventory()
	_refresh_currency()


func _unhandled_input(event):

	if event.is_action_pressed("inventory"):

		visible = !visible

		if visible:

			_refresh_inventory()
			_refresh_currency()


func _refresh_inventory():

	if inventory == null:
		return

	capacity_label.text = "%d / %d" % [
		inventory.items.size(),
		inventory.capacity
	]

	item_list.clear()

	for item in inventory.items:

		var text := item.item.item_name

		if item.amount > 1:
			text += " x%d" % item.amount

		item_list.add_item(
			text,
			item.item.icon
		)

	if inventory.items.is_empty():

		item_list.add_item("(Empty)")


func _refresh_currency(
	_currency := StringName(),
	_amount := 0
):

	if wallet == null:
		return

	for child in currency_list.get_children():
		child.queue_free()

	var currencies := wallet.get_all()

	if currencies.is_empty():

		var empty := Label.new()
		empty.text = "(No Currency)"
		currency_list.add_child(empty)
		return

	for id in currencies.keys():

		var label := Label.new()

		label.text = "%s : %d" % [
			String(id).capitalize(),
			wallet.get_amount(id)
		]

		currency_list.add_child(label)


func _on_item_clicked(
	index: int,
	_at_position: Vector2,
	_mouse_button_index: int
):

	if inventory == null:
		return

	if player == null:
		return

	if index < 0:
		return

	if index >= inventory.items.size():
		return

	var inventory_item := inventory.items[index]

	if inventory_item == null:
		return

	if inventory_item.item == null:
		return

	var success := inventory_item.item.use(
		player,
		inventory_item
	)
	if !success:
		return
	print("Use Success :", success)

	inventory.remove_inventory_item(
		inventory_item
	)
