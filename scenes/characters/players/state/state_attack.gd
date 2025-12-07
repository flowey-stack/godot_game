class_name PlayerStateAttack extends PlayerState

var attacking : bool = false
@onready var animation_player :AnimationPlayer = $"../../AnimationPlayer"
@onready var idle :PlayerState = $"../Idle"
@onready var walk : PlayerState = $"../Walk"

func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	attacking = true
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass

func Process(_delta :float) -> PlayerState:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else :
			return walk
	return null

func Physics(_delta : float) -> PlayerState:
	return null

func HandInput(_event :InputEvent) ->PlayerState:
	return null

func EndAttack(_newAnimName : String) -> void :
	attacking = false
