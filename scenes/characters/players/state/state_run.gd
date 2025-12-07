class_name PlayerStateRun extends PlayerState

@export var run_speed : float = 130.0

@onready var idle : PlayerState = $"../Idle"
@onready var walk : PlayerState = $"../Walk"

const  run_action = ("run")

func Enter() -> void:
	player.UpdateAnimation("run")

func Exit() -> void:
	pass

func Process(_delta :float) -> PlayerState:
	if not Input.is_action_pressed("run"):
		return walk
	
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * run_speed
	if player.SetDirection():
		player.UpdateAnimation("run")
	return null

func Physics(_delta : float) -> PlayerState:
	return null

func HandInput(_event :InputEvent) ->PlayerState:
	return null
