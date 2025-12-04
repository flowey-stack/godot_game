extends Node

# 你地圖一共有 3 個寶箱
const TOTAL_CHESTS := 3
var collected_chests := 0

# 新增：小遊戲結束後返回到哪裡（可在 Inspector 設定）
@export var return_scene: String = "res://scenes/level/day_1/progress_4.tscn"

@onready var chest_label: Label = $UI/ChestUI/HBoxContainer/Label
@onready var death_screen: CanvasLayer = $DeathScreen
@onready var death_rect: ColorRect = $DeathScreen/ColorRect

func _ready() -> void:
	death_rect.visible = false
	_update_chest_ui()

# --- 玩家蒐集寶箱時呼叫 ---
func chest_collected():
	collected_chests += 1
	_update_chest_ui()

	if collected_chests >= TOTAL_CHESTS:
		show_end_screen("You cleared the stage!")
		await get_tree().create_timer(2.0).timeout
		_return_to_original_scene()

# --- 玩家死亡時（kill_zone 調用）---
func player_died():
	show_end_screen("You died!")
	await get_tree().create_timer(2.0).timeout
	_return_to_original_scene()

# --- 顯示結束畫面通用方法 ---
func show_end_screen(text: String):
	death_rect.visible = true
	death_rect.modulate = Color(0, 0, 0, 0.75)

	var label := death_rect.get_node("Label")
	if label:
		label.text = text
	else:
		push_error("請在 DeathScreen/ColorRect 底下新增一個 Label！")

# --- 回到原本場景 ---
func _return_to_original_scene():
	if return_scene == "":
		push_error("return_scene 未設定！")
		return

	get_tree().change_scene_to_file(return_scene)

# --- 更新左上角寶箱 UI ---
func _update_chest_ui():
	chest_label.text = ": %d / %d" % [collected_chests, TOTAL_CHESTS]
