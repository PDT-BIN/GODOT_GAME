extends Area2D


@export var speed: int = 1000
var direction: Vector2 = Vector2.ZERO


func _ready():
	# START THE AUTO-DESTROY TIMER.
	$DestroyTimer.start()


func _process(delta):
	# MOVEMENT.
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()


func _on_destroy_timer_timeout():
	queue_free()
