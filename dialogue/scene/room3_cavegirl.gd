extends "res://dialogue/scene/cavegirl.gd"


@onready var animation = $AnimationPlayer

func _process(delta) :
	if player_in_area :
		if Input.is_action_just_pressed("interaction"):
			
			if first_dialogue_finished == false:
				run_dialogue("room3_cavegirl")
				
			else :
				run_dialogue("room3_cavegirl_repeat")
			
			
	pass

func DialogicSignal(arg : String):
	is_chatting = true
	
	if arg == "cat_head":
		animation.play("play_roll")
		await animation.animation_finished
		animation.play("RESET")
