class_name PlayerStateAttack extends PlayerState

var attacking : bool = false
@onready var animation_player :AnimationPlayer = $"../../AnimationPlayer"
@onready var idle :PlayerState = $"../Idle"
@onready var walk : PlayerState = $"../Walk"
@onready var attack_sound : AudioStreamPlayer2D = $"../../Sound/Attack"
@onready var hit_box : Area2D = $"../../HitBox"

func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	attack_sound.play()
	attacking = true
	
	hit_box.set_monitoring(true)
	hit_box.body_entered.connect(_on_hit_box_body_entered)
	
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	hit_box.body_entered.disconnect(_on_hit_box_body_entered)
	hit_box.set_monitoring(false)
	attacking = false
	pass

func Process(_delta :float) -> PlayerState:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else :
			return walk
	return null

func Physics(_delta : float) -> PlayerState:
	return null

func HandInput(_event :InputEvent) ->PlayerState:
	return null

func EndAttack(_newAnimName : String) -> void :
	hit_box.set_monitoring(false)
	attacking = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Ghost: # 假設您的敵人 class_name 是 Ghost
		if body.has_method("die"):
			body.die() # 呼叫敵人的死亡函式
			
			# 推薦：命中後立刻禁用監聽，防止一次攻擊殺死多個敵人或多次傷害同一敵人
			hit_box.set_monitoring(false)
