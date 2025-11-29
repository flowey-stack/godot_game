class_name Player extends CharacterBody2D

signal health_changed

@export var speed : int = 50
@onready var animations:AnimationPlayer = $AnimationPlayer
@onready var effects = $Effects
@onready var hurt_timer = $HurtTimer
@onready var hurt_box = $HurtBox
@onready var hurt_color = $Sprite2D/ColorRect
@onready var weapon = $Weapon
@onready var health_sound = $Sound/Health

@export var max_health = 3
@onready var current_health : int = max_health

@export var knock_back_power : int = 700

@export var inventory : Inventory



var last_anim_direction : String = "_down"
var is_hurt : bool = false
var is_attacking : bool = false

func _ready() :
	inventory.use_item.connect(use_item)
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	effects.play("RESET")


func handleInput():
	var moveDirection = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed
	
	if Input.is_action_just_pressed("attack"):
		attack()
		

func attack():
	animations.play("attack" + last_anim_direction)
	is_attacking = true
	weapon.enable()
	await animations.animation_finished
	weapon.disable()
	is_attacking = false

func updateAnimation():
	if is_attacking : return
	
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction= "_down"
		if velocity.x < 0:direction="_left"
		elif velocity.x > 0:direction="_right"
		elif velocity.y < 0:direction="_up"
	
		animations.play("walk" + direction)
		last_anim_direction = direction

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
	if !is_hurt:
		for area in hurt_box.get_overlapping_areas():
			if area.name == "HitBox":
				hurt_by_enemy(area)


	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animations.play("walk_" + direction)
	animations.stop()

func hurt_by_enemy(area):
	current_health -= 1
	if current_health < 0:
		current_health = max_health
	
	health_changed.emit(current_health)
	is_hurt = true
	knock_back(area.get_parent().velocity)
	
	effects.play("hurt_blink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
	is_hurt = false

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)


func knock_back(enemy_velocity : Vector2):
	var knock_back_direction = (enemy_velocity - velocity).normalized() * knock_back_power #撞擊力量
	velocity = knock_back_direction
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")


func _on_hurt_box_area_exited(area: Area2D) -> void:
	pass

func increase_health(amount: int)-> void:
	current_health += amount
	current_health = min(max_health, current_health)
	
	health_changed.emit(current_health)

func use_item(item: InventoryItem) -> void:
	if not item.can_be_used(self): return
	item.use(self)
	
	if item.consumable:
		inventory.remove_last_used_item()
	health_sound.play()
