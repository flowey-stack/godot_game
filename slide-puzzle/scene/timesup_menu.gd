extends CanvasLayer

signal exit

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level/home/room_2.tscn")
