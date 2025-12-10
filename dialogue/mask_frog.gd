extends CharacterBody2D

var is_chatting = false

var player_in_area = false

var player_node = null
var dialogic_node = null

func _ready():
	#dialogic_node = get_tree().get_first_node_in_group("dialogic_controller")
	#player_node = get_tree().get_first_node_in_group("Player")
	
	randomize()
	#Dialogic.signal_event.connect(DialogicSignal)
	#if dialogic_node:
		# 註冊對話結束函式
		#dialogic_node.timeline_end.connect(_on_dialogue_ended)
	pass

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			run_dialogue("main_frogman_talk")
			
	pass

func run_dialogue(dialogue_string):
	if player_node:
		player_node.set_movement_enabled(false)
	
	is_chatting = true
	
	var layout = Dialogic.Styles.load_style("角色對話")
	layout.register_character(load("res://dialogue/npc/frog_man.dch"), $".")
	Dialogic.start(dialogue_string)

func DialogicSignal(arg : String):
	if arg == "timeline訊號名稱":
		pass

func _on_chack_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_chack_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
	
	
func _on_dialogue_ended(timeline_name: String):
	is_chatting = false
	print("對話結束:", timeline_name)
	
	if player_node:
		# 恢復玩家移動
		player_node.set_movement_enabled(true)
