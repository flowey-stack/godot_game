extends Area2D
var timesup_menu_scene = preload("res://slide-puzzle/scene/timesup_menu.tscn")

var tiles = []
var solved = []
var tile_size = 250  # 假設每個方塊的大小為250x250
var grid_size = 4  # 4x4拼圖

#時間控制變數
var time_left = 30.0
var is_game_active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, 
	$Tile9, $Tile10, $Tile11, $Tile12, $Tile13, $Tile14, $Tile15, $Tile16]
	solved = tiles.duplicate()
	shuffle_tiles()
	update_timer_ui()
	
# 使用 _process 進行倒數
func _process(delta: float) -> void:
	if is_game_active:
		time_left -= delta
		update_timer_ui()
		
		if time_left <= 0:
			time_left = 0
			game_over_times_up()
			
#更新 UI 顯示 (記得場景要有名為 TimerLabel 的 Label)
func update_timer_ui():
	if %timerLabel:
		%timerLabel.text = "TIME: " + str(int(ceil(time_left)))
	else:
		print("cant find")

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
	# 如果遊戲結束 (時間到或已拼完)，就不再處理輸入
	if not is_game_active:
		return
		
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
			is_game_active = false

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
	
#時間到的處理函式
func game_over_times_up():
	print("Time's Up")
	is_game_active = false
	var menu_instance = timesup_menu_scene.instantiate()
	add_child(menu_instance)
	get_tree().paused = true
