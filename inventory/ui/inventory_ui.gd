extends CanvasLayer
class_name InventoryUI

@export var player_path: NodePath
@onready var capacity_label: Label = $PanelContainer/MarginContainer/VBoxContainer/CapacityLabel
@onready var currency_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/CurrencyList
@onready var item_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ItemList

const ROW_SCENE := preload(
	"res://inventory/ui/inventory_row.tscn"
)

var player
var inventory: Inventory
var wallet: Wallet


func _ready():
	
	visible = false

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

	for child in item_list.get_children():
		child.queue_free()

	for item in inventory.items:

		var row: InventoryRow = ROW_SCENE.instantiate()

		item_list.add_child(row)
		print(row.size)
		print(item_list.get_child_count())
		row.setup(item)
	if inventory.items.is_empty():
		var label := Label.new()

		label.text = "(Empty)"

		item_list.add_child(label)

func _refresh_currency(
	_currency := StringName(),
	_amount := 0
):

	if wallet == null:
		return

	for child in currency_list.get_children():
		child.queue_free()

	for id in wallet.get_all():

		var label := Label.new()

		label.text = "%s : %d" % [
			id,
			wallet.get_amount(id)
		]

		currency_list.add_child(label)
	if wallet.get_all().is_empty():

		var label := Label.new()

		label.text = "(No Currency)"

		currency_list.add_child(label)
