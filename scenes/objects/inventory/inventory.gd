extends Resource
class_name Inventory

signal updated
signal use_item

@export var slots : Array[InventorySlot]
var index_of_last_used_item: int = -1



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

func remove_slot(inventoty_slot : InventorySlot):
	var index = slots.find(inventoty_slot)
	if index < 0 : return
	
	remove_at_index(index)

func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insert_slot(index: int, inventory_slot: InventorySlot):
	slots[index] = inventory_slot
	updated.emit()

func use_item_at_index(index: int)->void :
	if index < 0 || index >=slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	index_of_last_used_item = index
	use_item.emit(slot.item)
	
func remove_last_used_item() -> void:
	if index_of_last_used_item <0:return
	var slot = slots[index_of_last_used_item]
	
	if slot.amount > 1:
		slot.amount -=1
		updated.emit()
		return
	
	remove_at_index(index_of_last_used_item)
