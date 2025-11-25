extends Node2D

@export var move_distance := 100
@export var move_speed := 60
@export var phase_offset := 0.0   # 新增：移動起始偏移（秒）

var start_position := Vector2.ZERO
var direction := 1
var velocity := Vector2.ZERO
var timer := 0.0   # 計時器

func _ready():
	start_position = global_position
	timer = phase_offset  # 每個平台的開始時間不同

func _physics_process(delta):
	timer += delta

	# 使用正弦波運動，會自然往返移動
	var t = sin(timer * move_speed / 50.0)
	global_position.y = start_position.y + t * move_distance
