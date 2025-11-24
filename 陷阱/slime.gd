extends CharacterBody2D

@export var move_range: float = 20.0  # 移動範圍一半（來回就是 200px）
@export var speed: float = 25.0        # 移動速度
@onready var timer: Timer = $Timer

var start_x: float
var direction: int = 1  # 1=右，-1=左

func _ready():
	start_x = global_position.x

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()

	# 到達邊界就反轉方向
	if abs(global_position.x - start_x) > move_range:
		direction *= -1




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("你已經死了")
		timer.start(	)

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
