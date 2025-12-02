extends Area2D

@export var target_scene: String = "res://fishing_game.tscn"

func _ready():
	input_pickable = true  # 確保 Area2D 可以接收滑鼠事件

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("切換到場景：", target_scene)
		get_tree().change_scene_to_file("res://釣魚/fishing_game.tscn")
