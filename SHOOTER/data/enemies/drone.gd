extends CharacterBody2D


# NOTICE AREA.
var is_actived: bool = false
const MAX_SPEED: int = 600
var speed: int = 0
var speed_ratio: int = 1
# DAMAGED.
var health: int = 50
var is_vulnerable: bool = true
var is_exploded: bool = false
const EXPLOSION_RADIUS: int = 400


func hit():
	if is_vulnerable:
		$Sounds/HitSound.play()
		is_vulnerable = false
		health -= 10
		$DroneImage.material.set_shader_parameter("alpha", 1)
		$HitTimer.start()
		if health <= 0:
			$AnimationPlayer.play("explosion")
			is_exploded = true


func _ready():
	$Explosion.hide()


func _process(delta):
	if is_actived:
		look_at(Global.player_pos)
		var direction = (Global.player_pos - position).normalized()
		velocity = direction * speed * speed_ratio
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			is_exploded = true
	if is_exploded:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var is_in_range = target.global_position.distance_to(global_position) < EXPLOSION_RADIUS
			if "hit" in target and is_in_range:
				target.hit()


func stop_movement():
	speed_ratio = 0


func explode():
	is_exploded = true


func _on_notice_area_body_entered(_body):
	is_actived = true
	create_tween().tween_property(self, "speed", MAX_SPEED, 6)


func _on_hit_timer_timeout():
	is_vulnerable = true
	$DroneImage.material.set_shader_parameter("alpha", 0)
