extends Area2D

@onready var timer: Timer = $Timer

# 設定延遲重載時間
@export var respawn_delay := 2.0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	# 只處理玩家
	if body.is_in_group("player"):
		print("玩家死亡:", body.name)
		
		# 顯示死亡畫面
		var gm_list = get_tree().get_nodes_in_group("game_manager")
		if gm_list.size() > 0:
			gm_list[0].player_died()
		
		# 停止玩家動作
		if "can_move" in body:
			body.can_move = false
		
		# 開始延遲重載
		timer.start(respawn_delay)

func _on_Timer_timeout() -> void:
	get_tree().reload_current_scene()
