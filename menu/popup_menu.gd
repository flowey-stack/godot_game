extends MarginContainer

@onready var volume_slider = %vHSlider
@export var menu_screen: VBoxContainer
@export var open_menu_screen: VBoxContainer
@export var help_menu_screen: MarginContainer
@export var setting_menu_screen: MarginContainer
@export var pause_menu_screen: MarginContainer

@export var open_menu_button: Button
@export var close_menu_button: Button
@export var open_help_button: Button
@export var close_help_button: Button
@export var open_settings_button: Button
@export var close_settings_button: Button
@export var open_pause_button: Button
@export var close_pause_button: Button
@export var open_quit_button: Button

var in_menu_buttons: Array
var close_menu_buttons: Array
var toggle_popupmenu_buttons: Array

# 獲取音效系統的 Master 頻道
var master_bus_index = AudioServer.get_bus_index("Master")


func _ready() -> void:
	in_menu_buttons = [open_help_button, open_settings_button, open_pause_button, open_quit_button]
	toggle_popupmenu_buttons = [open_menu_button, close_menu_button]
	close_menu_buttons = [close_help_button, close_settings_button, close_pause_button]
	
	#連接訊號 (當滑桿數值改變時，觸發函式)
	volume_slider.value_changed.connect(on_volume_changed)
	
	#初始化滑桿位置 (讀取當前設定)
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	
	call_deferred("setup_visibility_check")
	
	
func on_volume_changed(value):
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
	
	#如果拉到 0 就靜音
	if value == 0:
		AudioServer.set_bus_mute(master_bus_index, true)
	else:
		AudioServer.set_bus_mute(master_bus_index, false)
		

func setup_visibility_check():
	#遊戲剛開始時，先檢查一次要不要顯示
	check_ui_visibility()
	#監聽「場景切換」訊號，每次換場景都重新檢查一次
	get_tree().tree_changed.connect(check_ui_visibility)

func check_ui_visibility():
	# 安全鎖：如果 UI 自己還沒進入場景樹，就不要執行
	if not is_inside_tree():
		return
	
	var current_scene = get_tree().current_scene	
	
	# 安全鎖：如果場景還沒載入 (是 null)，就不要執行，直接返回
	if current_scene == null:
		return	
	
	if current_scene:
		# 獲取當前場景的檔案路徑 (例如 "res://scenes/main_menu.tscn")
		var path = current_scene.scene_file_path
		# 判斷邏輯：如果路徑裡包含 "main_menu" (請確認你的檔名)，就隱藏
		# 注意：這裡的字串 "main_menu" 必須要是你主選單檔名的一部分
		if "main_menu" in path or "MainMenu" in path:
			self.visible = false
			print("hide in game ui in main menu")
		else:
			self.visible = true
			print("appear in game ui")
	
func _process(delta):
	update_button_scale()
	
func update_button_scale():
	for button in in_menu_buttons:
		button_hov(button, 1.3, 0.2)
	for button in close_menu_buttons:
		button_hov(button, 1.5, 0.2)
	for button in toggle_popupmenu_buttons:
		button_hov(button, 2.0, 0.5)

func button_hov(button: Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)	
		
func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)
	

func toggle_visibility(object):
	var anim = $AnimationPlayer
	var animation_type: String
	if object.visible:
		animation_type = "close_"
	else:
		animation_type = "open_"
	anim.play(animation_type + str(object.name))
	


func _on_toggle_menu_button_pressed() -> void:
	toggle_visibility(menu_screen)
	#toggle_visibility(open_menu_screen)


func _on_toggle_help_menu_button_pressed() -> void:
	toggle_visibility(help_menu_screen)
	#menu screen will not appear
	#toggle_visibility(menu_screen)


func _on_toggle_setting_menu_button_pressed() -> void:
	toggle_visibility(setting_menu_screen)
	#toggle_visibility(menu_screen)


func _on_pause_button_pressed() -> void:
	toggle_visibility(pause_menu_screen)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
