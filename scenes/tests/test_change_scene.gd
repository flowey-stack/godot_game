extends Node2D
@onready var player: Player = $Node2D/Player
@onready var player_spawn_point: Marker2D = $PlayerSpawnPoint

func _ready() -> void:
	player.position = player_spawn_point.position #多出口時改player_spawn_point名稱
	
