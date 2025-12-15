extends Area2D

@export var target_scene: String = "res://snake/snake/scene/main.tscn"

func _ready():
	#確保 Area2D 可以接收滑鼠事件
	input_pickable = true  

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("切換到場景：", target_scene)
		get_tree().change_scene_to_file("res://snake/snake/scene/main.tscn")
