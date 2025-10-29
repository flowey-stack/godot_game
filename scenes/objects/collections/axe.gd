extends "res://scenes/objects/collections/collectable.gd"

@onready var animation = $AnimationPlayer

func collect(inventory : Inventory):
	animation.play("spin")
	await animation.animation_finished
	super(inventory)
