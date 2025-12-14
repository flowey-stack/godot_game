extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -350.0

var can_move := false    # 開場禁止移動


func _physics_process(delta: float) -> void:
	# 如果不能移動，直接結束這禎，玩家完全不會動
	if not can_move:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		play_animetion(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func play_animetion(direction):
	if direction < 0:
		$AnimatedSprite2D.play("left")
	if direction > 0:
		$AnimatedSprite2D.play("right")

	move_and_slide()
