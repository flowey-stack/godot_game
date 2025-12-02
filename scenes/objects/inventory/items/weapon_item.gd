class_name weaponItem extends InventoryItem

@export var weapon_class: PackedScene = preload("res://scenes/characters/players/axe.tscn")
var weapon

func _init() -> void:
	weapon = weapon_class.instantiate()

func use(player: Player) -> void:
	player.weapon.add_weapon(weapon)
