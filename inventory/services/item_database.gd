extends Node

var items: Dictionary = {}

func _ready() -> void:
	load_items()

func load_items() -> void:
	items.clear()

	var path := "res://inventory/resources/items"

	_scan_folder(path)

	print("[ItemDatabase] Loaded ", items.size(), " items.")

func _scan_folder(path: String) -> void:

	var dir := DirAccess.open(path)

	if dir == null:
		push_error("Cannot open folder : " + path)
		return

	dir.list_dir_begin()

	while true:

		var file := dir.get_next()

		if file == "":
			break

		if file.begins_with("."):
			continue

		var full_path := path + "/" + file

		if dir.current_is_dir():

			_scan_folder(full_path)

			continue

		if not file.ends_with(".tres"):
			continue

		var item := load(full_path)

		if item == null:
			continue

		if not item is BaseItem:
			continue

		if item.id.is_empty():

			push_warning(full_path + " has empty ID.")

			continue

		if items.has(item.id):

			push_error("Duplicate Item ID : " + item.id)

			continue

		items[item.id] = item

	dir.list_dir_end()

func get_item(id: String) -> BaseItem:

	if items.has(id):
		return items[id]

	push_warning("Item not found : " + id)

	return null

func has_item(id: String) -> bool:
	return items.has(id)

func get_all_items() -> Array[BaseItem]:

	var result : Array[BaseItem]

	for item in items.values():

		result.append(item)

	return result
