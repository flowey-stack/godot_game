class_name Ghost extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var hit = $Hit
@onready var sprite = $Sprite2D

@export_group("Textures")
@export var textures: Array[Texture2D] = []
@export_group("Vision Ranges")
@export var detection_radius := 100.0
@export var chase_radius := 200.0
# This guy doesn't actually attack, he just tries to get close to the player
@export var follow_radius := 25.0

var alive := true
var stunned := false

var is_death: bool = false

func _ready():
	sprite.texture = textures.pick_random()

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
