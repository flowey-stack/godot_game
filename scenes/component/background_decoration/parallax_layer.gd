extends ParallaxLayer

# 設置移動速度
@export var cloud_speed_x: float = 10.0 # 向右的速度
@export var cloud_speed_y: float = 10.0 # 向下的速度

func _process(delta: float):
	var layer = self as ParallaxLayer 

	# 1. 存取並計算新的 offset
	var current_offset: Vector2 = layer.scroll_offset

	current_offset.x += cloud_speed_x * delta
	current_offset.y += cloud_speed_y * delta
	
	# 2. 寫回屬性
	layer.scroll_offset = current_offset
