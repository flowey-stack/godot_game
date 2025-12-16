extends Node2D

func _ready() -> void:
	EventBus.crate_reached_dest.connect(_on_crate_reached_dest)
	
	if %bCompleteMenu:
		%bCompleteMenu.hide()
	
func _on_crate_reached_dest():
	for crate: Crate in get_tree().get_nodes_in_group("crates"):
		if not crate.is_reached:
			return
	print("Complete!")
	await get_tree().create_timer(0.5).timeout
	show_win_menu()
	
func show_win_menu():
	print("正在嘗試顯示選單...")
	if %bCompleteMenu:
		%bCompleteMenu.show()
		get_tree().paused = true
	else:
		print("error")
	
