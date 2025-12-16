extends "res://book_case_small.gd"

@onready var door = $"../../Doors/Door_corridor"

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("room2_bookcase_4")
				
			else :
				run_dialogue("room2_bookcase_4")
			
			
	pass

func DialogicSignal(arg : String):
	is_chatting = true
	
	if arg == "to_end":
		door.destination_door_tag = "end"
		door.destination_level_tag = "end_room"
		door.spawn_direction = "up"
