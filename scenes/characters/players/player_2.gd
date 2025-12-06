class_name Player2 extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var speed :float = 70
var state :String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


func _ready():
	pass

func _process(delta):
	
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = direction * speed
	
	
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	
	
	pass
	
func _physics_process(delta) :
	move_and_slide()




func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 
	return true


func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state :
		return false
	state = new_state
	return true

func UpdateAnimation() -> void:
	animation_player.play(state)
	
