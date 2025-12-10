class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $PlayerStateMachine

#
signal health_changed
@onready var effects = $Effects
@onready var hurt_timer = $HurtTimer
@onready var hurt_box = $HurtBox
@onready var hurt_color = $Sprite2D/ColorRect
@onready var heal_sound = $Sound/Heal
#
@onready var current_health : int = max_health
@export var max_health = 3
@export var knock_back_power : int = 1000
@export var inventory : Inventory
#
var is_hurt : bool = false
var is_attacking : bool = false
var can_move: bool = true

func _ready():
	state_machine.Initialize(self)
	inventory.use_item.connect(use_item)
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	pass

func _process(delta):
	if can_move:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	else:
		direction = Vector2.ZERO
	pass
	
func _physics_process(delta) :
	move_and_slide()
	#
	handle_collision()
	if !is_hurt:
		for area in hurt_box.get_overlapping_areas():
			if area.name == "HitBox":
				hurt_by_enemy(area)

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir= Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state)


#
func _on_hurt_box_area_exited(area: Area2D) -> void:
	pass
func handle_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

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
		print("get")
		area.collect(inventory)
func knock_back(enemy_velocity : Vector2):
	var knock_back_direction = (enemy_velocity - velocity).normalized() * knock_back_power #撞擊力量
	velocity = knock_back_direction
	move_and_slide()
func increase_health(amount: int)-> void:
	current_health += amount
	current_health = min(max_health, current_health)
	
	health_changed.emit(current_health)
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animation_player.play("walk")
	animation_player.stop()
func use_item(item: InventoryItem) -> void:
	if not item.can_be_used(self): return
	item.use(self)
	
	if item.consumable:
		inventory.remove_last_used_item()
	heal_sound.play()

#func set_movement_enabled(enabled: bool):
#	can_move = enabled
#	if not enabled:
#		direction = Vector2.ZERO 
	

func player():
	pass
