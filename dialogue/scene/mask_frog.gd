extends "res://dialogue/mask_frog.gd"

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			run_dialogue("progress2_frogman")
			
	pass
