class_name Player extends CharacterBody2D

@export var speed : int = 50
@onready var animations:AnimationPlayer = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction= "_down"
		if velocity.x < 0:direction="_left"
		elif velocity.x > 0:direction="_right"
		elif velocity.y < 0:direction="_up"
	
		animations.play("walk" + direction)

func _physics_process(delta) -> void:
	handleInput()
	move_and_slide()
	updateAnimation()

func _ready() :
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animations.play("walk_" + direction)
	animations.stop()
