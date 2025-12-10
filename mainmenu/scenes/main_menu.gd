class_name mainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/startButton as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/exitButton as Button
@onready var start_level = preload("res://scenes/level/day_1/main.tscn") as PackedScene


func _ready() -> void:
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	

	
func on_start_pressed():
	#get_tree().change_scene_to_packed(start_level)
	# 1. 取得 AnimationPlayer 節點
	var anim_player = $fadeTransition/AnimationPlayer
	
	# 2. 播放讓畫面變黑的動畫 ("fade_in")
	anim_player.play("fade_in")
	
	# 3. 等待動畫播放結束
	await anim_player.animation_finished
	
	# 4. 動畫播完後，才切換場景
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
