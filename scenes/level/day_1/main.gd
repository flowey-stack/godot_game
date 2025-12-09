extends "res://scenes/level/world/world.gd"

@onready var bgm = $AudioStreamPlayer2D

func _ready() -> void:
	Dialogic.start("first_main")
	if NavigationManager.spawn_door_tag !=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	bgm.play()
	
	heart_container.set_max_heart(player.max_health)
	heart_container.update_heart(player.current_health)
	player.health_changed.connect(heart_container.update_heart)
