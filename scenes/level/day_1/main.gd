extends "res://scenes/level/world/world.gd"

@onready var bgm = $AudioStreamPlayer2D

func _ready() -> void:
	if NavigationManager.spawn_door_tag !=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	bgm.play()
