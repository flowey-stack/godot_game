extends "res://book_case_small.gd"

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("room2_bookcase_1")
				
			else :
				run_dialogue("room2_bookcase_1")
			
			
	pass
