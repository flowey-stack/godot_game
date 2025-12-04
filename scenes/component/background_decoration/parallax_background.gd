extends ParallaxBackground

@export var scroll_speed: float = 10.0 # 設定您希望背景捲動的速度

func _process(delta):
	# 捲動視差背景的偏移量。
	# 增加 x 讓背景往左捲動 (Camera2D 的行為)，減少 x 則往右。
	scroll_offset.x += scroll_speed * delta
	scroll_offset.y += scroll_speed * delta
