extends Area2D

signal fish_caught

@export var aquaContainer: Control
const SPEED := 100

var overlapping_fish: Array = []

func _ready() -> void:
	monitoring = true
	monitorable = true
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
		var top_left = aquaContainer.get_global_position()
		var size = aquaContainer.rect_size

		var half_extents = Vector2.ZERO
		if $CollisionShape2D and $CollisionShape2D.shape:
			var shape = $CollisionShape2D.shape
			if shape is RectangleShape2D:
				half_extents = shape.extents
			elif shape is CircleShape2D:
				half_extents = Vector2(shape.radius, shape.radius)

		global_position.x = clamp(global_position.x, top_left.x + half_extents.x, top_left.x + size.x - half_extents.x)
		global_position.y = clamp(global_position.y, top_left.y + half_extents.y, top_left.y + size.y - half_extents.y)

	# 捕魚
	if Input.is_action_just_pressed("ui_accept") and overlapping_fish.size() > 0:
		var fish = overlapping_fish[0]
		if is_instance_valid(fish):
			print_debug("Attempt catch:", fish.name, " groups:", fish.get_groups())

			# ✔ 播放音效
			if $CatchSound:
				$CatchSound.play()
				print("播放音效!")

			fish.catch_fish()
			emit_signal("fish_caught")
			overlapping_fish.erase(fish)
		else:
			overlapping_fish = overlapping_fish.filter(func(x): return is_instance_valid(x))


func _on_body_entered(body: Node) -> void:
	print_debug("body_entered:", body, " name:", body.name, " groups:", body.get_groups())
	if body.is_in_group("fish"):
		if not overlapping_fish.has(body):
			overlapping_fish.append(body)


func _on_body_exited(body: Node) -> void:
	print_debug("body_exited:", body, " name:", body.name)
	if body.is_in_group("fish"):
		overlapping_fish.erase(body)


func _on_area_exited(area: Area2D) -> void:
	pass
