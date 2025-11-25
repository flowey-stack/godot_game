extends Node

@export var aquaContainer: Control
@export var fish_scenes: Array[PackedScene] = []
@export var min_fish: int = 2
@export var max_fish: int = 5
@export var min_scale: float = 0.5
@export var max_scale: float = 1
@export var max_total_fish: int = 10  # 魚缸最大數量

var fishing_game = null
var spawn_index := 0
var current_fish: Array = []  # 追蹤現有魚

func _ready() -> void:
	fishing_game = get_tree().get_current_scene()
	randomize()

	# 建立 Timer
	var t = get_node_or_null("Timer")
	if t == null:
		t = Timer.new()
		t.name = "Timer"
		t.wait_time = 1.0
		t.one_shot = false
		add_child(t)

	if not t.is_connected("timeout", Callable(self, "_on_timer_timeout")):
		t.timeout.connect(Callable(self, "_on_timer_timeout"))
	t.start()

	call_deferred("_spawn_initial_fish")


func _spawn_initial_fish() -> void:
	if fish_scenes.is_empty():
		push_error("FishSpawner: No fish scenes assigned!")
		return
	var n = randi_range(min_fish, max_fish)
	for i in n:
		_spawn_random_fish_deferred()


func _on_timer_timeout() -> void:
	if aquaContainer == null:
		return

	# 清掉已刪掉的魚
	current_fish = current_fish.filter(func(f): return is_instance_valid(f))

	var fish_count = current_fish.size()

	# 少於 5 條魚 → 隨機補 3~5 條，但不超過 max_total_fish
	if fish_count < 7:
		var num_to_spawn = randi_range(3, 5)
		for i in num_to_spawn:
			if current_fish.size() < max_total_fish:
				_spawn_random_fish_deferred()


func _spawn_random_fish_deferred() -> void:
	call_deferred("_spawn_random_fish")


func _spawn_random_fish() -> void:
	if fish_scenes.is_empty():
		return

	var idx = spawn_index % fish_scenes.size()
	spawn_index += 1
	var scene := fish_scenes[idx]
	if scene == null:
		push_warning("FishSpawner: fish_scenes[%d] is null" % idx)
		return

	var fish = scene.instantiate()
	if fish == null:
		push_error("FishSpawner: instantiate returned null for scene index %d" % idx)
		return

	if aquaContainer:
		var box = aquaContainer.get_global_rect()
		fish.global_position = Vector2(
			randf_range(box.position.x + 20, box.position.x + box.size.x - 20),
			randf_range(box.position.y + 20, box.position.y + box.size.y - 20)
		)

	var s = randf_range(min_scale, max_scale)
	fish.scale = Vector2(s, s)

	if "aquaContainer" in fish:
		fish.aquaContainer = aquaContainer

	if not fish.is_in_group("fish"):
		fish.add_to_group("fish")

	current_fish.append(fish)
	call_deferred("add_child", fish)
	call_deferred("_deferred_connect_fish_signal", fish)


func _deferred_connect_fish_signal(fish: Node) -> void:
	if fish == null:
		return

	# 正確使用 Callable，無 bind 參數
	if not fish.is_connected("fish_caught", Callable(self, "_on_fish_caught_local")):
		fish.connect("fish_caught", Callable(self, "_on_fish_caught_local"))

	# tree_exited signal，無 bind
	if not fish.is_connected("tree_exited", Callable(self, "_on_fish_removed")):
		fish.connect("tree_exited", Callable(self, "_on_fish_removed"))


func _on_fish_removed() -> void:
	# 移除 current_fish 中已不存在的魚
	current_fish = current_fish.filter(func(f): return is_instance_valid(f))


func _on_fish_caught_local(points) -> void:
	var p := 0
	if typeof(points) == TYPE_INT:
		p = points
	if fishing_game != null and fishing_game.has_method("add_score"):
		fishing_game.call_deferred("add_score", p)
	else:
		var fallback = get_tree().get_root().get_node_or_null("fishing_game")
		if fallback and fallback.has_method("add_score"):
			fallback.call_deferred("add_score", p)
		else:
			push_warning("FishSpawner: Could not find game instance to add score (points=%s)." % str(p))
