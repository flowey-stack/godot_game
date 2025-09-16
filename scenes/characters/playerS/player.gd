class_name Player extends CharacterBody2D

signal health_changed

@export var speed : int = 50
@onready var animations:AnimationPlayer = $AnimationPlayer
@onready var effects = $Effects
@onready var hurt_box = $HurtBox
@onready var hurt_color = $Sprite2D/ColorRect

@export var max_health = 3
@onready var current_health : int = max_health

@export var knock_back_power : int = 700

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

func handle_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _physics_process(delta) -> void:
	handleInput()
	move_and_slide()
	handle_collision()
	updateAnimation()

func _ready() :
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	effects.play("RESET")
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animations.play("walk_" + direction)
	animations.stop()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "HitBox":
		current_health -= 1
		if current_health < 0:
			current_health = max_health
		health_changed.emit(current_health)
		knock_back(area.get_parent().velocity)
		
		effects.play("hurt_blink")

func knock_back(enemy_velocity : Vector2):
	var knock_back_direction = (enemy_velocity - velocity).normalized() * knock_back_power #撞擊力量
	velocity = knock_back_direction
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")
