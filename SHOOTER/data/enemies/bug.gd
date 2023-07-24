extends CharacterBody2D


# DEFAULT.
const SPEED: int = 300
# NOTICE AREA.
var player_nearby: bool = false
# ATTACK AREA.
var is_actived: bool = false
# DAMAGED.
var health: int = 20
var is_vulnerable: bool = true


func hit():
	if is_vulnerable:
		$AudioStreamPlayer2D.play()
		is_vulnerable = false
		$Timers/HitTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("alpha", 1)
		$HitParticles.emitting = true
		health -= 10
		if health <= 0:
			await get_tree().create_timer(0.5).timeout
			queue_free()


func _process(_delta):
	var direction = (Global.player_pos - position).normalized()
	velocity = direction * SPEED
	if is_actived:
		move_and_slide()
		look_at(Global.player_pos)


func _on_attack_area_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("Attack")


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_notice_area_body_entered(_body):
	is_actived = true
	$AnimatedSprite2D.play("Walk")


func _on_notice_area_body_exited(_body):
	is_actived = false
	$AnimatedSprite2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if player_nearby:
		Global.health_quantity -= 10
		$Timers/AttackTimer.start()


func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("Attack")


func _on_hit_timer_timeout():
	is_vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("alpha", 0)
