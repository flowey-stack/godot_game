extends Node2D

@export var move_distance := 100
@export var move_speed := 60

var start_position := Vector2.ZERO
var direction := 1
var velocity := Vector2.ZERO  # 新增

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity = Vector2(0, move_speed * direction)
	global_position += velocity * delta

	if global_position.y > start_position.y + move_distance:
		direction = -1
	elif global_position.y < start_position.y:
		direction = 1
