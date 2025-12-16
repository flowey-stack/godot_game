extends Area2D
var clomplete_menu_scene = preload("res://slide-puzzle/scene/complete_menu.tscn")

var tiles = []
var solved = []
var tile_size = 250  # 假設每個方塊的大小為250x250
var grid_size = 4  # 4x4拼圖

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, 
	$Tile9, $Tile10, $Tile11, $Tile12, $Tile13, $Tile14, $Tile15, $Tile16]
	solved = tiles.duplicate()
	shuffle_tiles()

func shuffle_tiles():
	# 隨機打亂方塊
	for i in range(100):  # 執行100次隨機交換
		var tile1 = randi() % 16
		var tile2 = randi() % 16
		swap_tiles(tile1, tile2)

#func _process(delta: float) -> void:
#	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):  # 確保是左鍵按下
#		var mouse_pos = get_global_mouse_position()  # 取得鼠標位置
#		var rows = int(mouse_pos.y / tile_size)
#		var cols = int(mouse_pos.x / tile_size)
#		check_neighbours(rows, cols)

		# 檢查是否已經達成獲勝條件
#		if is_solved():
#			print("You win!")

func _input(event):
	# 偵測滑鼠左鍵是否被 "按下去" (只觸發一次)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		# 1. 使用 get_local_mouse_position() 自動處理 0.12 的縮放
		var local_pos = get_local_mouse_position()
		
		# 2. 算出是在第幾行、第幾列
		var rows = int(local_pos.y / tile_size)
		var cols = int(local_pos.x / tile_size)
		
		if rows < 0 or rows >= grid_size or cols < 0 or cols >= grid_size:
			return
		
		print("點擊座標: ", rows, ", ", cols) # 這行可以讓你知道有沒有點對
		
		# 3. 執行檢查與移動
		check_neighbours(rows, cols)
		
		# 4. 檢查勝利 (每次點擊後檢查一次就好)
		if is_solved():
			print("You win!")
			show_win_menu()

# 檢查方塊是否按正確的順序排列
func is_solved() -> bool:
	for i in range(16):
		if tiles[i] != solved[i]:
			return false
	return true

func check_neighbours(rows, cols):
	var pos = rows * grid_size + cols
	var empty = false
	var done = false
	while !empty and !done:
		var new_pos = tiles[pos].position
		if rows < grid_size - 1:
			new_pos.y += tile_size
			empty = find_empty(new_pos, pos)
			new_pos.y -= tile_size
		if rows > 0:
			new_pos.y -= tile_size
			empty = find_empty(new_pos, pos)
			new_pos.y += tile_size
		if cols < grid_size - 1:
			new_pos.x += tile_size
			empty = find_empty(new_pos, pos)
			new_pos.x -= tile_size
		if cols > 0:
			new_pos.x -= tile_size
			empty = find_empty(new_pos, pos)
			new_pos.x += tile_size
		done = true

func find_empty(position, pos):
	var new_rows = int(position.y / tile_size)
	var new_cols = int(position.x / tile_size)
	var new_pos = new_rows * grid_size + new_cols
	if tiles[new_pos] == $Tile16:
		swap_tiles(pos, new_pos)
		return true
	else:
		return false
	
func swap_tiles(tile_src, tile_dst):
	# 交換兩個方塊的位置
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile
	
func show_win_menu():
	var menu_instance = clomplete_menu_scene.instantiate()
	add_child(menu_instance)
	get_tree().paused = true
