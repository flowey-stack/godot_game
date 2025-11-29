class_name Sprite extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var hit = $Hit
@onready var sprite = $Sprite2D

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		animations.play("walk_down")
	if velocity.x > 0:
		sprite.flip_h = false
	if velocity.x < 0:
		sprite.flip_h = true


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area == $HitBox : return
	$HitBox.set_deferred("monitorable", false)
	animations.play("death")
	hit.play()
	await animations.animation_finished
	queue_free()
