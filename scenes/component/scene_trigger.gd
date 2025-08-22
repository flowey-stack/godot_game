class_name SceneTrigger extends Area2D

@export var connected_scene : String #要轉換的場景
#var scene_folder = "res://scenes/objects/room/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneChangeManager.change_scene(get_owner(), connected_scene)
	
	#var full_path = scene_folder + connected_scene + ".tscn"
	#var scene_tree = get_tree()
	#scene_tree.call_deferred("change_scene_to_file", full_path)
