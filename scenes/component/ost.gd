extends AudioStreamPlayer2D
@onready var ost = $"."

func _ready() -> void:
	ost.play()
