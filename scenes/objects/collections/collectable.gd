extends Area2D

@export var item_res : InventoryItem
@onready var sound = $AudioStreamPlayer2D

func collect(inventory : Inventory):
	inventory.insert(item_res)
	sound.play()
	queue_free()
