extends Node2D

func _ready():
	if SceneChangeManager.player:
		add_child(SceneChangeManager.player)
