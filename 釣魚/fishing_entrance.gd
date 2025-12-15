extends Area2D

@export var target_scene: String = "res://釣魚/fishing_game.tscn"
const PLAYER_GROUP = "Player"
var player_node = null

func _ready():
	player_node = get_tree().get_first_node_in_group(PLAYER_GROUP)
	input_pickable = true  # 確保 Area2D 可以接收滑鼠事件

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if player_node:
			GameManager.last_player_position = player_node.global_position
			print("儲存玩家位置:", GameManager.last_player_position)
		else:
			print("警告：找不到玩家節點來儲存位置！")
		
		print("切換到場景：", target_scene)
		get_tree().change_scene_to_file("res://釣魚/fishing_game.tscn")
