extends Node2D
@onready var player: Player = $Node2D/Player

@onready var heart_container = $CanvasLayer/HeartContainer


func _ready() -> void:	
	if NavigationManager.spawn_door_tag !=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	
	
	heart_container.set_max_heart(player.max_health)
	heart_container.update_heart(player.current_health)
	player.health_changed.connect(heart_container.update_heart)



func _on_level_spawn(destination_tag : String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false


func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
