extends Area2D
class_name WorldItem

const SCENE := preload(
	"res://inventory/world/world_item.tscn"
)

@export var floating_height := 6.0
@export var floating_speed := 4.0

var inventory_item: InventoryItem

@onready var sprite: Sprite2D = $Sprite2D
@onready var pickup_delay: Timer = $PickupDelay

var start_position: Vector2
var time := 0.0


func _ready():


	body_entered.connect(_on_body_entered)

	monitoring = false

	pickup_delay.timeout.connect(_enable_pickup)
	pickup_delay.start()

	if inventory_item != null:
		_update_visual()


func _process(delta):

	time += delta

	global_position.y = (
		start_position.y +
		sin(time * floating_speed) * floating_height
	)


func setup(item: InventoryItem):

	inventory_item = item

	start_position = global_position

	if is_node_ready():
		_update_visual()


func _update_visual():

	if inventory_item == null:
		return

	if inventory_item.item == null:
		return

	sprite.texture = inventory_item.item.icon


func _enable_pickup():

	monitoring = true


func _on_body_entered(body):

	if inventory_item == null:
		return

	if !body.is_in_group("player"):
		return

	if body.pickup == null:
		return

	var success = body.pickup.pickup_item(
		inventory_item
	)

	if success:
		queue_free()

static func spawn(
	parent: Node,
	position: Vector2,
	item: InventoryItem
):
	print("Spawn item:", item.item.item_name)
	print("Drop Position :", position)
	
	if item == null:
		return

	var world_item: WorldItem = SCENE.instantiate()

	parent.add_child(world_item)

	world_item.global_position = position
	world_item.start_position = position

	world_item.setup(item)
