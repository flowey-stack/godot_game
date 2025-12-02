extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var player = $"../player"
@onready var timer = $Timer

func _ready():
	timer.wait_time = 2.0
	timer.one_shot = true

	# 只在第一次遊戲進入顯示 ColorRect
	if global.first_time:
		color_rect.visible = true
		player.can_move = false   # 暫時禁止玩家移動
		timer.start()
		global.first_time = false
	else:
		color_rect.visible = false
		player.can_move = true    # 後續進入直接允許玩家移動

func _on_timer_timeout():
	color_rect.visible = false
	player.can_move = true
