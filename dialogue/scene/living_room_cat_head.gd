extends CharacterBody2D

var is_chatting = false

var player_in_area = false

var player_node = null
var dialogic_node = null
@onready var animation = $AnimationPlayer

var first_dialogue_finished: bool = false





func _ready():
	
	start_local_loop("play_roll_pro")
	randomize()
	Dialogic.signal_event.connect(DialogicSignal)
	pass

func start_local_loop(anim_name: String):
	# 確保動畫播放器有效
	if not is_instance_valid(animation):
		print("錯誤：AnimationPlayer 節點無效或未初始化。")
		return
		
	# 檢查目標動畫是否存在
	if not animation.has_animation(anim_name):
		print("錯誤：找不到動畫名稱: ", anim_name)
		return

	# 使用無限循環 (while true)
	while true:
		# 1. 播放動畫
		animation.play(anim_name)
		
		# 2. 暫停並等待 'animation_finished' 訊號
		# 這是關鍵步驟。一旦動畫播放完畢，程式碼將從這裡繼續執行。
		# 如果整個場景切換或此節點被釋放，await 會自動停止並中斷循環。
		await animation.animation_finished
		
		# 3. 再次進入循環頂部，重新播放動畫

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("living_room_cathead")
				
			else :
				run_dialogue("living_room_cathead_repeat")
			
			
	pass

func run_dialogue(dialogue_string):
	if player_node:
		player_node.set_movement_enabled(false)
	
	is_chatting = true
	first_dialogue_finished = true

	var layout = Dialogic.Styles.load_style("角色對話")
	layout.register_character(load("res://dialogue/npc/cat_head.dch"), $".")
	Dialogic.start(dialogue_string)
	

func DialogicSignal(arg : String):
	is_chatting = true
	
	if arg == "play_roll":
		animation.play("play_roll")
		await animation.animation_finished
		animation.play("idle")

func _on_chack_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_chack_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
	
	
func _on_dialogue_ended(timeline_name: String):
	is_chatting = false
	first_dialogue_finished = true
	print("對話結束:", timeline_name)
	
	if player_node:
		player_node.set_movement_enabled(true)
