extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# 只處理玩家
	if not body.is_in_group("player"):
		return

	# 找 GameManager 節點（透過 group）
	var gm_list = get_tree().get_nodes_in_group("game_manager")
	if gm_list.size() > 0:
		gm_list[0].chest_collected()

	# 收集後寶箱消失
	queue_free()
