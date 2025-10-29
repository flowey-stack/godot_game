extends Panel

@onready var back_ground_sprite : Sprite2D = $BackGround
@onready var item_sprite : Sprite2D = $CenterContainer/Panel/Item

func update(slot : InventorySlot):
	if !slot.item:
		back_ground_sprite.frame = 0
		item_sprite.visible = false
	else:
		back_ground_sprite.frame = 1
		item_sprite.visible = true
		item_sprite.texture = slot.item.texture
