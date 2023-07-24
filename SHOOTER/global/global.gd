extends Node


# UPDATE SIGNALS.
signal update_laser
signal update_grenade
signal update_health


# STATISTIC QUANTITY.
var laser_quantity: int = 20:
	get:
		return laser_quantity
	set(value):
		laser_quantity = value
		update_laser.emit()

var grenade_quantity: int = 5:
	get:
		return grenade_quantity
	set(value):
		grenade_quantity = value
		update_grenade.emit()

var is_vulnerable: bool = true
var health_quantity: int = 75:
	get:
		return health_quantity
	set(value):
		if value > health_quantity:
			health_quantity = min(value, 100)
		else:
			if is_vulnerable:
				# VULNERABLE TIMER.
				is_vulnerable = false
				player_vulnerable_timer()
				# UPDATE HEALTH.
				health_quantity = value
				player_hit_sound.play()
		update_health.emit()

func player_vulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	is_vulnerable = true


# PLAYER POSITION.
var player_pos: Vector2
# HIT AUDIO.
var player_hit_sound: AudioStreamPlayer2D


func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
