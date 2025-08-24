extends Node2D
@onready var player: Player = $Node2D/Player
@onready var player_spawn_point: Marker2D = $Room/PlayerSpawnPoint

func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	if TransitionChangeManager.is_transitioning:
		player.position = player_spawn_point.position #多出口時改player_spawn_point名稱
		player.set_process_input(false)
		player.set_physics_process(false)
	
	
	
func on_transition_done():
	player.set_process_input(true)
	player.set_physics_process(true)
