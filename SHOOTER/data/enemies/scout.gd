extends CharacterBody2D


# ATTACK.
var player_nearby: bool = false
var can_laser: bool = true
signal laser(pos, shoot_direction)
var shooting_gun: bool = true

# DAMAGED.
var health: int = 30
var is_vulnerable: bool = true


func hit():
	if is_vulnerable:
		$AudioStreamPlayer2D.play()
		health -= 10
		if health == 0:
			queue_free()
		is_vulnerable = false
		$Timers/HitTimer.start()
		$ScoutImage.material.set_shader_parameter("alpha", 1)


func _process(_delta):
	# SHOOT.
	if player_nearby:
		look_at(Global.player_pos)
		if can_laser:
			var pos = $LaserSpawnPositions.get_child(shooting_gun).global_position
			shooting_gun = not shooting_gun
			var shoot_direction = (Global.player_pos - position).normalized()
			laser.emit(pos, shoot_direction)
			# START COOLDOWN.
			can_laser = false
			$Timers/LaserTimer.start()


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_timer_timeout():
	can_laser = true


func _on_hit_timer_timeout():
	is_vulnerable = true
	$ScoutImage.material.set_shader_parameter("alpha", 0)
