extends "res://scenes/level/world/world.gd"


func _ready() -> void:
	if NavigationManager.spawn_door_tag !=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	player_node = get_tree().get_first_node_in_group(PLAYER_GROUP)
	if GameManager.last_player_position != Vector2.ZERO:
		if player_node:
			player_node.global_position = GameManager.last_player_position
			GameManager.last_player_position = Vector2.ZERO   
		
	heart_container.set_max_heart(player.max_health)
	heart_container.update_heart(player.current_health)
	player.health_changed.connect(heart_container.update_heart)

func _on_level_spawn(destination_tag  : String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
