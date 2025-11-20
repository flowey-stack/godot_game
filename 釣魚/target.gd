extends Area2D

signal fish_caught

@export var aquaContainer: Control
const SPEED := 100

var overlapping_fish: Array = []

func _ready() -> void:
	# 確保 Area2D 有在監聽
	monitoring = true
	monitorable = true

	# 連接 body_entered / body_exited signal
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if not is_connected("body_exited", Callable(self, "_on_body_exited")):
		connect("body_exited", Callable(self, "_on_body_exited"))

	print_debug("Target ready. Collision layer:", collision_layer, " mask:", collision_mask)

func _physics_process(delta: float) -> void:
	# 玩家移動
	var dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	global_position += dir * SPEED * delta

	# 限制範圍（若有 aquaContainer）
	if aquaContainer and is_instance_valid(aquaContainer):
		var box = aquaContainer.get_global_rect()

		var half_extents = Vector2.ZERO
		var cs = $CollisionShape2D
		if cs and cs.shape:
			match cs.shape:
				RectangleShape2D:
					half_extents = cs.shape.extents
				CircleShape2D:
					half_extents = Vector2(cs.shape.radius, cs.shape.radius)

		global_position.x = clamp(global_position.x, box.position.x + half_extents.x, box.position.x + box.size.x - half_extents.x)
		global_position.y = clamp(global_position.y, box.position.y + half_extents.y, box.position.y + box.size.y - half_extents.y)

	# 捕魚（空白鍵）
	if Input.is_action_just_pressed("ui_accept") and overlapping_fish.size() > 0:
		var fish = overlapping_fish[0]
		if is_instance_valid(fish):
			print_debug("Attempt catch:", fish.name, " groups:", fish.get_groups())
			fish.catch_fish()
			emit_signal("fish_caught")
			overlapping_fish.erase(fish)
		else:
			overlapping_fish = overlapping_fish.filter(func(x): return is_instance_valid(x))

# Signals
func _on_body_entered(body: Node) -> void:
	print_debug("body_entered:", body, " name:", body.name, " groups:", body.get_groups())
	if body.is_in_group("fish") and not overlapping_fish.has(body):
		overlapping_fish.append(body)

func _on_body_exited(body: Node) -> void:
	print_debug("body_exited:", body, " name:", body.name)
	if body.is_in_group("fish"):
		overlapping_fish.erase(body)

func _on_area_exited(area: Area2D) -> void:
	pass
