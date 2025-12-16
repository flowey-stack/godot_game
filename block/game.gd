extends Node2D


func _ready() -> void:
	EventBus.crate_reached_dest.connect(_on_crate_reached_dest)
	
func _on_crate_reached_dest():
	for crate: Crate in get_tree().get_nodes_in_group("crates"):
		if not crate.is_reached:
			return
	print("Complete!")
	get_tree().change_scene_to_file("res://scenes/level/day_1/progress_1.tscn")
