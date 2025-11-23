extends Resource
class_name Inventory

signal updated

@export var slots : Array[InventorySlot]

func insert(item : InventoryItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount +=1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	
	updated.emit()

func remove_item_at_index(index: int):
	slots[index] = InventorySlot.new()

func insert_slot(index: int, inventory_slot: InventorySlot):
	var old_index : int = slots.find(inventory_slot)
	remove_item_at_index(old_index)
	
	slots[index] = inventory_slot
