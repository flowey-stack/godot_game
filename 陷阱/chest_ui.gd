extends CanvasLayer

@onready var label = $Label

func update_chest_count(collected: int, total: int):
	label.text = "Chests: %d/%d" % [collected, total]
