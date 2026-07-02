extends Resource
class_name LootEntry

@export var item_id: StringName

@export_range(0.0,100.0)
var chance := 100.0

@export var min_amount := 1
@export var max_amount := 1
