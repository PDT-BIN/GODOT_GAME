extends Node2D
class_name LevelParent

# ATTACHED SENCES.
var laser_scene: PackedScene = preload("res://data/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://data/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://data/items/item.tscn")


# GENERAL.
func create_laser(pos: Vector2, shoot_direction: Vector2):
	var laser = laser_scene.instantiate() as Area2D
	# UPDATE START POSITION.
	laser.position = pos
	# UPDATE THE DIRECTION.
	laser.direction = shoot_direction
	# THE LASER MOVE BY ITSELF.
	# ROTATE THE LASER.
	laser.rotation_degrees = rad_to_deg(shoot_direction.angle()) + 90
	# ADD LASER TO PROJECTILES NODE.
	$Projectiles.add_child(laser)


# PLAYER SIGNAL.
func _on_player_laser(pos, shoot_direction):
	create_laser(pos, shoot_direction)


func _on_player_grenade(pos, shoot_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	# UPDATE START POSITION.
	grenade.position = pos
	# MOVE AND ROTATE THE GRENADE.
	grenade.linear_velocity = shoot_direction * grenade.SPEED
	# ADD GRENADE TO PROJECTILES NODE.
	$Projectiles.add_child(grenade)


# SCOUT SIGNAL.
func _on_scout_laser(pos, shoot_direction):
	create_laser(pos, shoot_direction)


# CONTAINER SIGNAL.
func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)


func _on_container_opened(pos, spawn_direction):
	var item = item_scene.instantiate() as Area2D
	item.position = pos
	item.direction = spawn_direction
	$Items.call_deferred("add_child", item)
