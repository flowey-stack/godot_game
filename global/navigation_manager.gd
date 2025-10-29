extends Node

const scene_world = preload("res://scenes/level/world/world.tscn")
const scene_mine = preload("res://scenes/level/mine/mine.tscn")
const scene_room_1 = preload("res://scenes/room/room_1.tscn")
#Day1
const scene_day_1_main = preload("res://scenes/level/day_1/main.tscn")
const scene_day_1_progress_1 = preload("res://scenes/level/day_1/progress_1.tscn")
const scene_day_1_progress_2 = preload("res://scenes/level/day_1/progress_2.tscn")
const scene_day_1_progress_3 = preload("res://scenes/level/day_1/progress_3.tscn")
const scene_day_1_progress_4 = preload("res://scenes/level/day_1/progress_4.tscn")
const scene_day_1_hidden = preload("res://scenes/level/day_1/hidden.tscn")
const scene_day_1_progress_5 =preload("res://scenes/level/day_1/progress_5.tscn")

signal on_trigger_player_spawn 

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"world" :
			scene_to_load = scene_world
		"mine" :
			scene_to_load = scene_mine
		"room_1":
			scene_to_load = scene_room_1
		#day1
		"main" :
			scene_to_load = scene_day_1_main
		"progress_1" :
			scene_to_load = scene_day_1_progress_1
		"progress_2" :
			scene_to_load = scene_day_1_progress_2
		"progress_3" :
			scene_to_load = scene_day_1_progress_3
		"progress_4" :
			scene_to_load = scene_day_1_progress_4
		"hidden" :
			scene_to_load = scene_day_1_hidden
		"progress_5" :
			scene_to_load = scene_day_1_progress_5
		
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
