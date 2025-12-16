extends CharacterBody2D

var is_chatting = false

var player_in_area = false

var player_node = null
var dialogic_node = null


var first_dialogue_finished: bool = false
@onready var play_piano = $AudioStreamPlayer2D


func _ready():

	
	randomize()
	Dialogic.signal_event.connect(DialogicSignal)
	pass

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("room2_piano")
				
			else :
				run_dialogue("room2_piano")
			
			
	pass

func run_dialogue(dialogue_string):
	if player_node:
		player_node.set_movement_enabled(false)
	
	is_chatting = true
	first_dialogue_finished = true

	#var layout = Dialogic.Styles.load_style("New_File")
	#layout.register_character(load("res://dialogue/npc/bookcase_small.dch"), $".")
	Dialogic.start(dialogue_string)
	

func DialogicSignal(arg : String):
	is_chatting = true
	
	if arg == "play_piano":
		play_piano.play()

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
