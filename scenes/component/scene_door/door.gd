class_name Door
extends Area2D

@export var destination_level_tag : String #要抵達的場景
@export var destination_door_tag : String #要抵達的門名稱
@export var spawn_direction = "up" #碰到spawn時的spawn方向

@onready var spawn = $Spawn


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		#if not is_instance_valid(destination_door_tag):
			#print("錯誤：門節點 ", name, " destination_door_tag")
			#return
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag,spawn.global_position,spawn_direction)
