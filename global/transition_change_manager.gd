class_name TransitionManager extends CanvasLayer

signal transition_done

@export var transition_time = 0.3

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
	tween.tween_property(color_rect, "modulate:a", 1, transition_time)
	tween.finished.connect(on_fade_out_completed)

func on_fade_out_completed():
	get_tree().change_scene_to_file(next_scene_path)
	fade_in()

func fade_in():
	color_rect.modulate.a = 1
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate:a", 0, transition_time)
	
	tween.finished.connect(on_fade_in_finished)

func on_fade_in_finished():
	is_transitioning = false
	transition_done.emit()

func change_scene(next_scene_path: String):
	if is_transitioning:
		return
	
	self.next_scene_path = next_scene_path
	fade_out()
	
