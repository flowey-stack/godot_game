extends Area2D

signal fish_caught

const SPEED := 150
var overlapping_fish: Array = []

func _ready():
	monitoring = true
	monitorable = true
	set_physics_process(true)
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS

	print("=== TARGET READY ===")
	print("Physics:", is_physics_processing(), " Input:", is_processing_input())
	print("====================")

func _physics_process(delta):
	var dir_x = Input.get_axis("ui_left", "ui_right")
	var dir_y = Input.get_axis("ui_up", "ui_down")
	var dir = Vector2(dir_x, dir_y)

	if dir.length() > 0:
		global_position += dir.normalized() * SPEED * delta

	# 範圍限制
	var top_left = Vector2(0, 0)
	var size = Vector2(1150, 600)
	var half_extents = Vector2.ZERO
	if $CollisionShape2D and $CollisionShape2D.shape:
		var shape = $CollisionShape2D.shape
		if shape is RectangleShape2D:
			half_extents = shape.extents
		elif shape is CircleShape2D:
			half_extents = Vector2(shape.radius, shape.radius)

	global_position.x = clamp(global_position.x, top_left.x + half_extents.x, top_left.x + size.x - half_extents.x)
	global_position.y = clamp(global_position.y, top_left.y + half_extents.y, top_left.y + size.y - half_extents.y)

	if Engine.get_frames_drawn() % 20 == 0:
		print("Target position:", global_position, "Input axis:", dir_x, dir_y)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("fish"):
		if not overlapping_fish.has(body):
			overlapping_fish.append(body)
			print("Fish enter:", body.name)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("fish"):
		overlapping_fish.erase(body)
		print("Fish exit:", body.name)
