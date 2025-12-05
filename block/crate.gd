class_name Crate
extends "res://game_object.gd"


var is_reached := false:
	set(v):
		if is_reached == v:
			return
		is_reached = v
		animation_player.play("reached" if is_reached else "default")
		if is_reached:
			EventBus.crate_reached_dest.emit()
		
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func move_to(cell: Vector2i):
	super(cell)
	is_reached = is_dest(cell)
