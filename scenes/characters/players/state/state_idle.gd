class_name PlayerStateIdle extends PlayerState

@onready var walk : PlayerState = $"../Walk"
@onready var attack : PlayerState = $"../Attack"
func Enter() -> void:
	player.UpdateAnimation("idle")

func Exit() -> void:
	pass

func Process(_delta :float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func Physics(_delta : float) -> PlayerState:
	return null

func HandInput(_event :InputEvent) ->PlayerState:
	if _event.is_action_pressed("attack"):
		return attack
	return null
