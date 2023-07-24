extends Area2D


# SETTINGS.
const ROTATE_SPEED: int = 4
const TYPE_OPTIONS: Array[String] = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type: String = TYPE_OPTIONS[randi() % len(TYPE_OPTIONS)]
var direction: Vector2
var distance: int = randi_range(150, 250)


func _ready():
	match type:
		'laser':
			$ItemImage.modulate = Color(0.1, 0.2, 0.8)
		'grenade':
			$ItemImage.modulate = Color(0.8, 0.2, 0.1)
		'health':
			$ItemImage.modulate = Color(0.1, 0.8, 0.1)
	# MOVEMENT TWEEN.
	var destination = position + direction * distance
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", destination, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2.ZERO)


func _process(delta):
	rotation += ROTATE_SPEED * delta


func _on_body_entered(_body):
	match type:
		"laser":
			Global.laser_quantity += 5
		"grenade":
			Global.grenade_quantity += 1
		"health":
			Global.health_quantity += 10
	$AudioStreamPlayer2D.play()
	$ItemImage.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
