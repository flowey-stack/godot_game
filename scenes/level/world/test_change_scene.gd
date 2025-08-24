extends Node2D
@onready var player: Player = $Node2D/Player
@onready var player_spawn_point: Marker2D = $Room/PlayerSpawnPoint

func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	if TransitionChangeManager.is_transitioning:
		player.position = player_spawn_point.position #多出口時改player_spawn_point名稱
		player.set_process_input(false)
		player.set_physics_process(false)
	
	
	if NavigationManager.spawn_door_tag !=null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	
	
func on_transition_done():
	player.set_process_input(true)
	player.set_physics_process(true)





func _on_level_spawn(destination_tag : String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
