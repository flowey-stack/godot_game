extends CharacterBody2D

@onready var animation = $AnimationPlayer

func _ready() -> void:
	animation.play("idle")
