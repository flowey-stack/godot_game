extends Node2D

func _ready() -> void:
	if SceneChangeManager.player:
		add_child(SceneChangeManager.player)
