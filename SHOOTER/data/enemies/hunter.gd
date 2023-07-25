extends CharacterBody2D


# NOTICE AREA.
var is_actived: bool = false
const SPEED: int = 200
# ATTACK AREA.
var player_nearby: bool = false
# DAMAGED.
var health: int = 100
var is_vulnerable: bool = true


func hit():
	if is_vulnerable:
		is_vulnerable = false
		health -= 10
		$Timers/HitTimer.start()
		if health <= 0:
			queue_free()


func attack():
	if player_nearby:
		Global.health_quantity -= 20


func _ready():
	$NavigationAgent2D.path_desired_distance = 5.0
	$NavigationAgent2D.target_desired_distance = 5.0


func _physics_process(_delta):
	if is_actived:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		rotation = direction.angle() + PI / 2


func _on_notice_area_body_entered(_body):
	is_actived = true
	$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(_body):
	is_actived = false
	$AnimationPlayer.stop()


func _on_attack_area_body_entered(_body):
	player_nearby = true
	$AnimationPlayer.play("attack")
	$Timers/AttackTimer.start()


func _on_attack_area_body_exited(_body):
	player_nearby = false
	$AnimationPlayer.play("walk")


func _on_path_timer_timeout():
	if is_actived:
		$NavigationAgent2D.target_position = Global.player_pos


func _on_attack_timer_timeout():
	if player_nearby:
		$AnimationPlayer.play("attack")
		$Timers/AttackTimer.start()


func _on_hit_timer_timeout():
	is_vulnerable = true
