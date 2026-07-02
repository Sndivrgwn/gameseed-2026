extends Resource
class_name BaseItem

@export_group("Info")

@export var id : String
@export var item_name : String
@export_multiline var description : String

@export var icon : Texture2D

@export_group("Inventory")

@export var max_stack : int = 1
@export var sell_price : int = 0
@export var item_type : ItemType.Type
