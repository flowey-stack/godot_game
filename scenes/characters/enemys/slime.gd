extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var end_point = Marker2D

@onready var animations = $AnimationPlayer
@onready var hit = $Hit


var start_position
var end_position

var is_death : bool = false

func _ready() -> void:
	start_position = position
	end_position = end_point.global_position

func change_direction():
	var temp_end = end_position
	end_position = start_position
	start_position = temp_end

func update_velosity() :
	var move_direction = (end_position - position)
	if move_direction.length() < limit:
		change_direction()
	velocity = move_direction.normalized()*speed

func update_animation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction= "_down"
		if velocity.x < 0:direction="_left"
		elif velocity.x > 0:direction="_right"
		elif velocity.y < 0:direction="_up"
		
		animations.play("walk" + direction)
	

func _physics_process(delta):
	if is_death : return
	update_velosity()
	move_and_slide()
	update_animation()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area == $HitBox : return
	$HitBox.set_deferred("monitorable", false)
	is_death = true
	animations.play("death")
	hit.play()
	await animations.animation_finished
	queue_free()
