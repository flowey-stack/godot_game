extends "res://dialogue/scene/cavegirl.gd"
func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("progress1_cavegirl")
				
			else :
				run_dialogue("progress1_cavegirl_repeat")
			
			
	pass
