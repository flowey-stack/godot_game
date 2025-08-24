class_name Door
extends Area2D

@export var destination_level : String #要抵達的場景
@export var destination_door : String #要抵達的門名稱
@export var spawn_direction = "up" #碰到spawn時的spawn方向

@onready var spawn = $Spawn


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
