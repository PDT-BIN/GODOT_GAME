extends CharacterBody2D

# SHOOT.
var can_laser: bool = true
var can_grenade: bool = true
signal laser(pos, shoot_direction)
signal grenade(pos, shoot_direction)
# START GAME.
@export var max_speed: int = 500
var speed: int = max_speed


# DAMAGED.
func hit():
	Global.health_quantity -= 10


func _process(_delta):
	# MOVEMENT.
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Global.player_pos = global_position
	# ROTATION.
	look_at(get_global_mouse_position())
	# SHOOT LASER.
	if Input.is_action_pressed("primary action") and can_laser and Global.laser_quantity > 0:
		# REDUCE LASER QUANTITY.
		Global.laser_quantity -= 1
		# GET THE PLAYER DIRECTION.
		var player_direction = (get_global_mouse_position() - position).normalized()
		# RANDOMLY LASER START POSITION.
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		# SHOOT.
		can_laser = false
		$LaserTimer.start()
		$ShootParticle.emitting = true
		laser.emit(selected_laser.global_position, player_direction)
	# SHOOT GRENADE.
	if Input.is_action_pressed("secondary action") and can_grenade and Global.grenade_quantity > 0:
		# REDUCE GRENADE QUANTITY.
		Global.grenade_quantity -= 1
		# GET THE PLAYER DIRECTION.
		var player_direction = (get_global_mouse_position() - position).normalized()
		# PICK MIDDLE START POSITION.
		var selected_grenade = $LaserStartPositions.get_children()[0]
		# SHOOT.
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_grenade.global_position, player_direction)


# SHOOT TIMER.
func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
