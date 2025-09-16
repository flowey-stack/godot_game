extends Panel

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

func update(whole : bool):
	if whole : sprite.frame = 4
	else : sprite.frame = 0
	animation.play("shake")
