extends CanvasLayer

signal restart

func _on_restart_button_pressed() -> void:
	restart.emit()

func set_score(value):
	$ScoreLabel.text = "SCORE:" + str(value)
