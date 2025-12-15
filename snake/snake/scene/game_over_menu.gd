extends CanvasLayer

signal restart

func _on_restart_button_pressed() -> void:
	#restart.emit()
	get_tree().change_scene_to_file("res://scenes/level/day_1/main.tscn")

func set_score(value):
	$GameOverPanel/VBoxContainer/ScoreLabel.text = "SCORE:" + str(value)
	
