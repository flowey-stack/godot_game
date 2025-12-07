class_name PlayerStateWalk extends PlayerState

@export var move_speed : float = 70.0

@onready var idle : PlayerState = $"../Idle"
@onready var run : PlayerState = $"../Run"
@onready var attack : PlayerState = $"../Attack"

const  run_action = "run"

func Enter() -> void:
	player.UpdateAnimation("walk")

func Exit() -> void:
	pass

func Process(_delta :float) -> PlayerState:
	
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null

func Physics(_delta : float) -> PlayerState:
	return null

func HandInput(_event :InputEvent) ->PlayerState:
	if Input.is_action_pressed("run"):
		return run
	if _event.is_action_pressed("attack"):
		return attack
	return null
