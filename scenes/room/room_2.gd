extends Node2D
const PLAYER_SCENE = preload("res://scenes/characters/players/player.tscn")
@onready var player_spawn_place_marker: Marker2D = $PlayerSpawnPlace

func _ready() -> void:
	TransitionChangeManager.transition_done.connect(on_transition_done)
	var player = PLAYER_SCENE.instantiate()
	player.set_physics_process(false)
	player.set_process_input(false)
	self.add_child(player)
	
	player.position = player_spawn_place_marker.position

func on_transition_done():
	$Player.set_physics_process(true)
	$Player.set_process_input(true)


func _on_exit_area_body_entered(body: Node2D) -> void:
	TransitionChangeManager.change_scene("res://scenes/tests/test_change_scene.tscn")
