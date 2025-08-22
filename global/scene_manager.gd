class_name SceneManager extends Node
var player: Player

var scene_dir_path = "res://scenes/"

func change_scene(from, to_scene_name: String) -> void:
	player = from.get_node("Player")
	player.get_parent().remove_child(player)
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deffered("change_scene_to_file", full_path)
