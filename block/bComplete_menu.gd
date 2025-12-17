extends CanvasLayer

signal exit

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level/day_1/progress_1.tscn")
