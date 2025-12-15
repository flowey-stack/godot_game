extends CanvasLayer

signal exit

func _on_exit_button_pressed() -> void:
	#restart.emit()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level/day_1/main.tscn")
	

func set_score(value):
	$GameOverPanel/VBoxContainer/ScoreLabel.text = "SCORE:" + str(value)
