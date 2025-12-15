extends Area2D

@export var target_scene: String = "res://slide-puzzle/scene/main.tscn"
const PLAYER_GROUP = "Player"
var player_node = null

func _ready():
	player_node = get_tree().get_first_node_in_group(PLAYER_GROUP)
	
	if player_node == null:
		# ⚠️ 【診斷訊息】如果找不到，立即警告
		print("【錯誤警告】在場景 ", get_tree().current_scene.name, " 中找不到群組為 '", PLAYER_GROUP, "' 的玩家節點！")
	else:
		print("【診斷】玩家節點查找成功，可以儲存位置。")
	
	#確保 Area2D 可以接收滑鼠事件
	input_pickable = true  

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if player_node:
			GameManager.last_player_position = player_node.global_position
			print("儲存玩家位置:", GameManager.last_player_position)
		else:
			print("【失敗】無法儲存位置，因為 player_node 為 null！")
		print("切換到場景：", target_scene)
		get_tree().change_scene_to_file("res://slide-puzzle/scene/main.tscn")
