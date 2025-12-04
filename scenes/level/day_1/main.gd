extends "res://scenes/level/world/world.gd"

@onready var bgm = $AudioStreamPlayer2D

func _ready() -> void:
	bgm.play()
	
