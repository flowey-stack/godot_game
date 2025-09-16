extends HBoxContainer

@onready var heart_ui_class = preload("res://scenes/ui/health/heart_ui.tscn")

func set_max_heart(max : int):
	for i in range(max):
		var heart = heart_ui_class.instantiate()
		add_child(heart)

func update_heart(current_health : int):
	var heart = get_children()
	
	for i in range(current_health):
		heart[i].update(true)
	
	for i in range(current_health, heart.size()):
		heart[i].update(false)
