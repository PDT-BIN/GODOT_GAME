extends PathFollow2D


# NOTICE AREA.
var player_nearby: bool = false
# LASER GUNS.
@onready var laser_1: Line2D = $Turret/RayCast_1/LaserLine
@onready var laser_2: Line2D = $Turret/RayCast_2/LaserLine
@onready var fire_1: Sprite2D = $Turret/RayCast_1/FireImage
@onready var fire_2: Sprite2D = $Turret/RayCast_2/FireImage


func fire():
	Global.health_quantity -= 20
	# DISPLAY THE FIRE.
	fire_1.modulate.a = 1
	fire_2.modulate.a = 1
	# HIDE THE FIRE.
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(fire_1, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(fire_2, "modulate:a", 0, randf_range(0.1, 0.5))


func _ready():
	laser_2.add_point($Turret/RayCast_2.target_position)


func _process(delta):
	progress_ratio += 0.02 * delta
	if player_nearby:
		$Turret.look_at(Global.player_pos)


func _on_notice_area_body_entered(_body):
	player_nearby = true
	$AnimationPlayer.play("laser_load")


func _on_notice_area_body_exited(_body):
	player_nearby = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(laser_1, "width", 0, 0.25)
	tween.tween_property(laser_2, "width", 0, 0.25)
	await tween.finished
	$AnimationPlayer.stop()
