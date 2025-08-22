class_name TransitionManager extends CanvasLayer

signal transition_done

@export var transition_time = 0.5

@onready var color_rect: ColorRect = $ColorRect
 
var next_scene_path: String
var is_transitioning = false
var player_spawn_position = null

func _ready() -> void:
	color_rect.modulate.a = 0

func fade_out() :
	is_transitioning = true
	color_rect.modulate.a = 0
	color_rect.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate.a", 1, transition_time)
