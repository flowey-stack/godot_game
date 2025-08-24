class_name SceneTrigger extends Area2D

@export var connected_fold : String
@export var connected_scene : String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneChangeManager.change_scene(get_owner(), connected_fold, connected_scene)
