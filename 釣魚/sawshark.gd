extends CharacterBody2D

signal fish_caught(fish: Node)

# -------------------
# 節點綁定
# -------------------
@export var aquaContainer: Control
@onready var fish_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# -------------------
# 移動參數
# -------------------
const SPEED := 80.0
var targetPosition: Vector2
var is_stopped := false   # 用於遊戲結束停止移動

# -------------------
# 初始化
# -------------------
func _ready() -> void:
	# 每隻魚加入同一個 group，Target 才能捕捉到
	add_to_group("fish")
	_set_new_target_position()

# -------------------
# 隨機新目標位置
# -------------------
func _set_new_target_position() -> void:
	if aquaContainer == null:
		push_error("Fish.gd: aquaContainer is null! Please assign AquaContainer before using.")
		return
	var box = aquaContainer.get_global_rect()
	targetPosition = Vector2(
		randi_range(box.position.x + 10, box.position.x + box.size.x - 10),
		randi_range(box.position.y + 10, box.position.y + box.size.y - 10)
	)

# -------------------
# 每幀移動
# -------------------
func _physics_process(delta: float) -> void:
	if aquaContainer == null:
		return

	if not is_stopped:
		var direction := (targetPosition - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

		if global_position.distance_to(targetPosition) < 5:
			_set_new_target_position()

		# 根據水平方向切換動畫
		if direction.x < 0:
			fish_sprite.play("left")
		else:
			fish_sprite.play("right")
	else:
		# 停止移動但動畫持續播放
		if fish_sprite.is_playing() == false:
			fish_sprite.play()

# -------------------
# 捕捉魚
# -------------------
func catch_fish() -> void:
	emit_signal("fish_caught", self)
	queue_free()

# -------------------
# 停止移動（遊戲結束用）
# -------------------
func stop_moving():
	is_stopped = true
