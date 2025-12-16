extends Node

#Day1
const scene_main = preload("res://scenes/level/day_1/main.tscn")
const scene_progress_1 = preload("res://scenes/level/day_1/progress_1.tscn")
const scene_progress_2 = preload("res://scenes/level/day_1/progress_2.tscn")
const scene_progress_3 = preload("res://scenes/level/day_1/progress_3.tscn")
const scene_progress_4 = preload("res://scenes/level/day_1/progress_4.tscn")
const scene_hidden = preload("res://scenes/level/day_1/hidden.tscn")

const scene_home = preload("res://scenes/level/home/home.tscn")
const scene_living_room = preload("res://scenes/level/home/living_room.tscn")
const scene_corridor = preload("res://scenes/level/home/corridor.tscn")
const scene_room_1 = preload("res://scenes/level/home/room_1.tscn")
const scene_room_2 = preload("res://scenes/level/home/room_2.tscn")

const end_room = preload("res://scenes/level/home/room_3.tscn")  

signal on_trigger_player_spawn 

var spawn_door_tag

func go_to_level(level_tag, destination_tag,spawn_pos: Vector2, spawn_dir: String):
	var scene_to_load
	
	match level_tag:
		#day1
		"main" :
			scene_to_load = scene_main
		"progress_1" :
			scene_to_load = scene_progress_1
		"progress_2" :
			scene_to_load = scene_progress_2
		"progress_3" :
			scene_to_load = scene_progress_3
		"progress_4" :
			scene_to_load = scene_progress_4
		"hidden" :
			scene_to_load = scene_hidden
		"home" :
			scene_to_load = scene_home
		"living_room" :
			scene_to_load = scene_living_room
		"corridor":
			scene_to_load = scene_corridor
		"room_1":
			scene_to_load = scene_room_1
		"room_2":
			scene_to_load = scene_room_2
			
		"end_room":
			scene_to_load = end_room
	
	
	if scene_to_load != null:
		var transition_speed: float = 0.8
		if level_tag == "home" or level_tag == "end_room": #or level_tag == "room_2" or level_tag == "hidden":
			transition_speed = 0.3 # 進入這些關鍵場景時，速度變慢 (例如慢三倍)
		
		TransitionScreen.transition(transition_speed)
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		
		trigger_player_spawn(spawn_pos, spawn_dir)
		
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
