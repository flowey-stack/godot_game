extends Area2D

# ----------------------------------------------------
# 導出變數：在編輯器中設置對話路徑
# ----------------------------------------------------

# (Required) 填寫您在 Dialogic 2 創建的 Timeline 路徑
@export var dialogue_timeline_path: String = "res://dialogue/timeline/home_fishing.dtl"

# (Optional) 假設您的玩家在 "player" 群組中
const PLAYER_GROUP_NAME = "Player"

# ----------------------------------------------------
# 狀態旗標：確保對話只進行一次的關鍵
# ----------------------------------------------------
var has_dialogue_started: bool = false
var dialogic_node: Node = null


func _ready():
	# 1. 查找 Dialogic 節點 (透過群組查找，這是最可靠的方式)
	dialogic_node = get_tree().get_first_node_in_group("Dialogic")
	
	if dialogic_node == null:
		print("錯誤：找不到 'dialogic_controller' 群組中的 Dialogic 節點！")
		return

	# 2. 連接訊號：當有物體進入此 Area2D 時
	# 訊號名稱：body_entered (請確保您的玩家是 PhysicsBody2D 類型，例如 CharacterBody2D)
	# 連接目標函式：_on_body_entered
	body_entered.connect(_on_body_entered)


# ----------------------------------------------------
# 訊號處理函式：進入區域時觸發
# ----------------------------------------------------
func _on_body_entered(body: Node2D):
	# 檢查 1: 確保進入的是玩家
	# 檢查 2: 確保對話尚未開始過 (!has_dialogue_started)
	if body.is_in_group(PLAYER_GROUP_NAME) and not has_dialogue_started:
		
		# 狀態控制：立即設置為 true，阻止後續再次觸發
		has_dialogue_started = true
		
		# 可選：在對話開始前暫停玩家移動 (需要在玩家腳本中實現相關邏輯)
		# body.can_move = false 
		
		# 啟動對話
		Dialogic.start("home_fishing")
		
		# (可選) 連接 `timeline_end` 訊號，用於在對話結束後恢復遊戲狀態
		# 使用 CONNECT_ONE_SHOT 標誌，讓連接在第一次發出訊號後自動斷開
		#dialogic_node.timeline_end.connect(_on_dialogue_end, CONNECT_ONE_SHOT)
		
		# 觸發後銷毀此節點：這是確保「只發生一次」最徹底的方法
		queue_free()


# ----------------------------------------------------
# 訊號處理函式：對話結束時觸發
# ----------------------------------------------------
func _on_dialogue_end(timeline_name: String):
	print("對話結束:", timeline_name)
	# 在這裡恢復遊戲狀態，例如：
	# var player = get_tree().get_first_node_in_group(PLAYER_GROUP_NAME)
	# if player:
	#     player.can_move = true
	pass
