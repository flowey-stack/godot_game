extends Button

@onready var back_ground_sprite : Sprite2D = $BackGround
@onready var container :CenterContainer = $CenterContainer

@onready var inventory = preload("res://scenes/objects/inventory/player_inventory.tres")

var item_stack_gui : ItemStackGui
var index : int
func insert(isg : ItemStackGui):
	item_stack_gui = isg
	back_ground_sprite.frame = 1
	container.add_child(item_stack_gui)
	
	if !item_stack_gui.inventory_slot || inventory.slots[index] == item_stack_gui.inventory_slot:
		return
	
	inventory.insert_slot(index, item_stack_gui.inventory_slot)

func take_item():
	var item = item_stack_gui
	
	container.remove_child(item_stack_gui)
	item_stack_gui = null
	back_ground_sprite.frame = 0
	
	return item

func is_empty():
	return !item_stack_gui

func _on_pressed() -> void:
	pass # Replace with function body.
