extends CharacterBody2D

signal fish_caught(points)

@export var SPEED: float = 50.0
@export var points: int = 10  # 抓到這條魚加多少分
@export var min_x := 10
@export var max_x := 280
@export var min_y := 10
@export var max_y := 160

var target_position: Vector2
@onready var fish_sprite = $AnimatedSprite2D

func _ready():
	_set_new_target_position()

func _physics_process(delta):
	var direction = (target_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()

	# 根據方向播放不同動畫
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			fish_sprite.play("right")
		else:
			fish_sprite.play("left")

	# 到達目標位置後重新選目標
	if global_position.distance_to(target_position) < 10:
		_set_new_target_position()

func _set_new_target_position():
	target_position = Vector2(
		randf_range(min_x, max_x),
		randf_range(min_y, max_y)
	)

# 當被抓到時呼叫這個
func catch_fish():
	if not is_queued_for_deletion():
		emit_signal("fish_caught", points)
		queue_free()
